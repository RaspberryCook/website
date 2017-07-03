class AddIconsToAllergens < ActiveRecord::Migration
  def up
    add_column :allergens, :icon, :string

    {
      'sans céleri'        => 'celery',
      'sans crustacé'      => 'crustacens',
      'sans oeuf'          => 'eggs',
      'sans poisson'       => 'fish',
      'sans lactose'       => 'milk',
      'sans fruits de mer' => 'molluscs',
      'sans moutarde'      => 'mustard',
      'sans arachide'      => 'peanut',
      'sans sésame'        => 'sesame',
      'sans soja'          => 'soya',
      'sans sulphite'      => 'sulphurdioxide',
      'sans noisette'      => 'treenut',
      'sans gluten'        => 'wheat',

    }.each{ |name, icon|
      if allergen = Allergen.find_by('name',  name)
        allergen.icon = icon
        allergen.save
      else
        Allergen.create name: name, icon: icon
      end
    }

  end


  def down
    remove_column :allergens, :icon
    Allergen.delete_all
  end
end
