class CreateTableRecipesAllergens < ActiveRecord::Migration
  def change
    create_table :allergens_recipes, :id => false do |t|
       t.references :recipe
       t.references :allergen
       t.timestamps
    end
  end
end
