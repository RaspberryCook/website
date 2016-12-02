# Global helpers for to use in views
module RecipesHelper

  def best_recipes_json

    data = []

    View.select(:recipe_id).group(:recipe_id).each do |group|
      data << "['azaz', 2]" % group.recipe_id
    end



    return data.to_json

    
  end

end