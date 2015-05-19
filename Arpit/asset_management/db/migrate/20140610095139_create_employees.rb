class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :employee_number
      t.string :designation
      t.string :technology
      t.string :department
      t.references :location, index: true
      t.datetime :join_date
      t.datetime :resign_date
      t.string :skype_id
      t.string :pm_tool_id
      t.string :pandian_id
      t.string :wiki_id
      t.string :sapience_id
      t.string :helpdesk_id

      t.timestamps
    end
  end
end
