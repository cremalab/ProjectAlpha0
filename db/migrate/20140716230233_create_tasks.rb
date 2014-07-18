class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :name
      t.string :stripe_id
      t.string :stage
      t.string :assigned_hour
      t.references :task_board, index: true

      t.timestamps
    end
  end
end
