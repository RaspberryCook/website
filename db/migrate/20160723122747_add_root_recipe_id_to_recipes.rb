class AddRootRecipeIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :root_recipe_id, :integer, :default => false
  end
end
