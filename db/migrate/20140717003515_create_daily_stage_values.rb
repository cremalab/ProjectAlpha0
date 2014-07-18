class CreateDailyStageValues < ActiveRecord::Migration
  def change
    create_table :daily_stage_values do |t|
      t.text :name
      t.integer :amount

      t.references :task_board, index: true

      t.timestamps
    end
  end
end
