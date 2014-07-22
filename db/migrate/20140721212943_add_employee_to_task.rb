class AddEmployeeToTask < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.references :employee, index: true
    end

    change_table :employees do |t|
      t.remove :employee_id
    end


  end
end
