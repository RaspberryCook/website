class CreateViews < ActiveRecord::Migration
  def change
    
    create_table :views do |t|
      t.timestamps null: false
      t.integer :user_id
      t.integer :recipe_id
    end

    remove_column :recipes, :views

  end
end
