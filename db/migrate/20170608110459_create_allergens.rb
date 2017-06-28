class CreateAllergens < ActiveRecord::Migration
  def change
    create_table :allergens do |t|
      t.string :name

      t.timestamps null: false
    end

    remove_column :recipes, :tags

    ['sans gluten', 'sans crustacé', 'sans oeuf', 'sans poisson', 'sans arachide', 'sans lactose', 'sans sulphite'].each { |allergen|
      Allergen.create name: allergen
    }
  end
end
