class AddThingsToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :name, :string
    add_column :ingredients, :protein, :integer
    add_column :ingredients, :carbohydrates, :integer
    add_column :ingredients, :lipids, :integer
  end
end
