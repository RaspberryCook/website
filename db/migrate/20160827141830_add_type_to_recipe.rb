class AddTypeToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :rtype, :string
  end
end
