class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :asana_id
      t.string :harvest_id
      t.string :email

      t.timestamps
    end
    change_table :employees do |t|
      t.references :employee, index: true
    end

  end
end
