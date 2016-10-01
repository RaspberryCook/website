class RemoveColumnPasswordToUsers < ActiveRecord::Migration
	def change
		remove_column :users, :salt
		rename_column :users, :encrypted_password, :password
	end
end
