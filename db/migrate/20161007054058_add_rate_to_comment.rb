class AddRateToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :rate, :integer
  	remove_column :comments, :note
  end
end
