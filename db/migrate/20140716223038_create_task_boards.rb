class CreateTaskBoards < ActiveRecord::Migration
  def change
    create_table :task_boards do |t|
      t.string :stripe_id
      t.string :name

      t.timestamps
    end
  end
end
