class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text   :content
      t.belongs_to :user
      t.timestamps
    end
  end
end
