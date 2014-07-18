class TaskBoard < ActiveRecord::Base
  has_many :tasks
  has_many :daily_stage_values

  def self.get_task_boards(api_key, workspace_id)
    uri = URI.parse("https://app.asana.com/api/1.0/workspaces/#{workspace_id}/projects/")
    projects = HttpHelper.get_request(uri, api_key)

    projects.each do |project|
      if project["name"] =~ /(.*) - Task Board$/
        task_board = TaskBoard.where(stripe_id: project["id"].to_s)
        if task_board.empty?
          self.create(name: project["name"], stripe_id: project["id"])
        end
      end
    end
  end

  def get_tasks(task_board_id, api_key)
    url = "https://app.asana.com/api/1.0/projects/#{task_board_id}/tasks"
    params = "?opt_fields=assignee,name"
    uri = URI.parse(url + params)
    tasks = HttpHelper.get_request(uri, api_key)
    tag = nil

    tasks.each do |task|
      p "Tasks"
      p task
      if task["name"] =~ /.*:$/
        tag = task["name"][0..-2]
      else
        a_task = Task.where(stripe_id: task["id"].to_s, created_at: (Time.now.midnight)..Time.now.midnight + 1.day)
        if a_task.empty?
          a_task = Task.create(
            stripe_id: task["id"].to_s,
            name: task["name"],
            task_board_id: self.id,
            stage: tag
          )
          a_task.set_hours
        end
      end
    end
  end

  def get_daily_stage_values
    stages = self.tasks.select(:stage).map(&:stage).uniq
    stages.each do |stage|
      amount = self.tasks.where(stage: stage).length
      total_hours = self.tasks.where(stage: stage).pluck(:assigned_hour)
      total_hours = total_hours.compact.map {|x| x.to_f}
      sum = 0
      total_hours.each {|x| sum += x}
      total_hours = sum
      if stage.nil?
        stage = "(No Heading)"
      end

      daily_stage_value = self.daily_stage_values.where(name: stage, created_at: (Time.now.midnight)..Time.now.midnight + 1.day)
      if daily_stage_value.empty?

        DailyStageValue.create(name: stage, amount: amount, task_board_id: self.id, total_hours: total_hours)
      end
    end
  end
end
