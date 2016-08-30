class RemoveCategoryToRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :category
  end
end
