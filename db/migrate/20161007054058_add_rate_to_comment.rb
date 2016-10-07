class AddRateToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :rate, :integer, :default => 5
  	remove_column :comments, :note
  end
end
