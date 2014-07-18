class TotalHours < ActiveRecord::Migration
  def change
    change_table :daily_stage_values do |t|
      t.float :total_hours, default: 0
    end

  end
end
