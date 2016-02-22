class AddColumnsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ingredients, :text
    add_column :recipes, :steps, :text
    add_column :recipes, :category, :string
    add_column :recipes, :season, :string
    add_column :recipes, :t_baking, :integer
    add_column :recipes, :t_cooling, :integer
    add_column :recipes, :t_cooking, :integer
    add_column :recipes, :t_rest, :integer
  end
end
