class MovePasswordToEncryptedPasswordToUsers < ActiveRecord::Migration
	def change
		rename_column :users, :password, :encrypted_password
	end
end
