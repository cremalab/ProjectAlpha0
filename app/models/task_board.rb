class TaskBoard < ActiveRecord::Base
  has_many :tasks
  has_many :daily_stage_values

  def self.get_task_boards(api_key, workspace_id)
    uri = URI.parse("https://app.asana.com/api/1.0/workspaces/#{workspace_id}/projects/")
    projects = HttpHelper.get_request(uri, api_key)

    projects.each do |project|
      if project["name"] =~ /(.*) - Task Board$/
        task_board = self.where(name: project["name"])
        if task_board.empty?
          self.create(name: project["name"], stripe_id: project["id"])
        end
      end
    end
  end

  def get_tasks(task_board_id, api_key)
    uri = URI.parse("https://app.asana.com/api/1.0/projects/#{task_board_id}/tasks/")
    tasks = HttpHelper.get_request(uri, api_key)
    tag = nil

    tasks.each do |task|
      if task["name"] =~ /(.*):$/
        tag = task["name"][0..-2]
      else
        a_task = Task.where(stripe_id: task["id"].to_s, created_at: (Time.now.midnight)..Time.now.midnight + 1.day)
        p a_task
        if a_task.empty?
          Task.create(
            stripe_id: task["id"].to_s,
            name: task["name"],
            task_board_id: self.id,
            stage: tag,
            assigned_hour: "Later"
          )
        end
      end
    end
  end

  def get_daily_stage_values
    stages = self.tasks.select(:stage).map(&:stage).uniq
    stages.each do |stage|
      amount = self.tasks.where(stage: stage).length
      daily_stage_value = self.daily_stage_values.where(name: stage, created_at: (Time.now.midnight)..Time.now.midnight + 1.day)
      if daily_stage_value.empty?
        DailyStageValue.create(name: stage, amount: amount, task_board_id: self.id)
      end
    end
  end
end
