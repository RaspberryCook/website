class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :open_food_fact_id
      t.string :name
      t.float :quantity
      t.float :sugars
      t.float :sodium
      t.float :carbohydrates
      t.float :proteins
      t.float :fat
      t.float :saturated_fat
      t.float :salt
      t.float :fiber
      t.float :energy

      t.timestamps null: false
    end
  end
end
