class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :full_name, null: false
      t.string :job_title, null: false
      t.string :country, null: false
      t.decimal :salary, precision: 12, scale: 2, null: false
      t.string :email, null: false
      t.string :department
      t.date :joining_date
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :employees, :country
    add_index :employees, :job_title
    add_index :employees, :salary
    add_index :employees, :email, unique: true
    add_index :employees, [ :country, :job_title ]
  end
end
