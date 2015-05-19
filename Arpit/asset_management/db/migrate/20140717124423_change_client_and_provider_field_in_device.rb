class ChangeClientAndProviderFieldInDevice < ActiveRecord::Migration
  def change
  	remove_column 	:devices, :provider
  	remove_column 	:devices, :client_name
  	add_column 		:devices, :client_id,:integer
  end
end
