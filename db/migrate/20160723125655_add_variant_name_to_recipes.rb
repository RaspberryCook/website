class AddVariantNameToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :variant_name, :string
  end
end
