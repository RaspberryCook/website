class ConvertPreptimeToIntegerOnRecipes < ActiveRecord::Migration
  def up
    add_column :recipes, :baking,  :integer, default: 0
    add_column :recipes, :cooling,  :integer, default: 0
    add_column :recipes, :rest,  :integer, default: 0
    add_column :recipes, :cooking,  :integer, default: 0
  end

  def down
    remove_column :recipes, :baking
    remove_column :recipes, :cooling
    remove_column :recipes, :rest
    remove_column :recipes, :cooking
  end
end
