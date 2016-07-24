class ChangeColumnTRestToRecipes < ActiveRecord::Migration
  def change
  	change_column :recipes, :t_baking,  :time
  	change_column :recipes, :t_cooling,  :time
  	change_column :recipes, :t_rest,  :time
  	change_column :recipes, :t_cooking,  :time
  end
end
