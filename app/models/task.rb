class Task < ActiveRecord::Base
  belongs_to :task_board
  belongs_to :employee

  def set_hours
    hour_regex = [/\d*\.?\d*\s?hr?/]
    result = hour_regex[0].match(self.name)
    result = /\d*\.?\d*/.match(result.to_s)
    unless result.to_s.empty?
      self.assigned_hour = result.to_s.to_f
      self.save!
    end
  end

end
