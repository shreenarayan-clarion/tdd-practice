class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :content
      t.datetime :date

      t.timestamps null: false
    end
  end
end
