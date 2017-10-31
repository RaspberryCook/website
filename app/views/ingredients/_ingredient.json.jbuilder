json.extract! ingredient, :id, :open_food_fact_id, :name, :quantity, :sugars, :sodium, :carbohydrates, :proteins, :fat, :saturated_fat, :salt, :fiber, :energy, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
