class RenameAndAddColumnsToUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :nom, :firstname
  	add_column :users, :lastname, :string
  end
end
