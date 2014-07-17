class ActiveInactive < ActiveRecord::Migration
  def change
    change_table :task_boards do |t|
      t.boolean :active, default: true



    end

  end
end
