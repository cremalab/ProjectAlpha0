class GroupBarDsgController < ApplicationController
  def index
    @dsg = DailyStageValue.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day)
  end
end
