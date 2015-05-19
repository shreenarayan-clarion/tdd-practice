class SetWarrentyFieldsInDevice < ActiveRecord::Migration
  def change
  	remove_column 	:devices, :warranty
  	add_column		:devices ,:warranry_year,:string
  	add_column		:devices ,:warranry_month,:string
  	add_column		:devices ,:lifetime_warranty ,:boolean
  end
end
