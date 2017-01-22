# migration inspired from https://github.com/binarylogic/authlogic#example-migration

class MakeExampleMigrationToUsers < ActiveRecord::Migration
	def change
		add_index :users, :email, unique: true
		remove_column :users, :encrypted_password, :crypted_password

		# Authlogic::ActsAsAuthentic::Password
		add_column :users, :crypted_password, :string
		add_column :users, :password_salt, :string

		# Authlogic::ActsAsAuthentic::PersistenceToken
		# add_column :users, :persistence_token

		# Authlogic::ActsAsAuthentic::SingleAccessToken
		add_column :users, :single_access_token, :string

		# Authlogic::ActsAsAuthentic::PerishableToken
		add_column :users, :perishable_token, :string

		# Authlogic::Session::MagicColumns
		add_column :users, :login_count, :integer, default: 0, null: false
		add_column :users, :failed_login_count, :integer, default: 0, null: false
		add_column :users, :last_request_at, :datetime
		add_column :users, :current_login_at, :datetime
		add_column :users, :last_login_at, :datetime
		add_column :users, :current_login_ip, :string
		add_column :users, :last_login_ip, :string

		# Authlogic::Session::MagicStates
		# add_column :users, :active, :boolean, default: false
		# add_column :users, :approved, :boolean, default: false
		# add_column :users, :confirmed, :boolean, default: false

	end

end
