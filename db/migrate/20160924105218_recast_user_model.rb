class RecastUserModel < ActiveRecord::Migration
	def change
  		rename_column :users, :firstname, :username
  		add_column :users, :firstname, :string
  		remove_column :users, :admin
	end
end
