class AddSlugToRecipes < ActiveRecord::Migration
  def up
    add_column :recipes, :slug, :string
    add_index :recipes, :slug, unique: true

    say_with_time 'generating recipe slugs' do
      Recipe.find_each(&:save)
    end
  end

  def down
    remove_column :recipes, :slug, :string
  end
end
