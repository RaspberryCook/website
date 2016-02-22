class AddKcalToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :kcal, :integer
  end
end
