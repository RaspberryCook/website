class AddViewsOnRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :views, :integer, :default => 0
  end
end
