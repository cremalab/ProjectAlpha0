
require "net/http"
require "pp"

namespace :get_information do

  task asana_tasks: :environment do
    api_key = "1TbckKlf.HEIYurEMmUSJie30cOlZyFl"
    workspace_id = "287827460117"
    TaskBoard.get_task_boards(api_key, workspace_id)

    task_boards = TaskBoard.where(active: true)

    task_boards.each do |task_board|
      task_board.get_tasks(task_board.stripe_id, api_key)
      task_board.get_daily_stage_values
    end


  end

  task asana_daily_stage: :environment do
    task_boards = TaskBoard.where(active: true)

    task_boards.each do |task_board|
      task_board.get_daily_stage_values
    end
  end

  task set_hours: :environment do
    tasks = Task.all

    tasks.each do |task|
      task.set_hours
    end
  end


end