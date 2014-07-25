class GroupBarDsgController < ApplicationController
  def index
    @dsg = DailyStageValue.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day)
    @active_task_boards = TaskBoard.where(active: true)
  end
end
