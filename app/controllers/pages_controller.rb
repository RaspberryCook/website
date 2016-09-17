class PagesController < ApplicationController
  
  def home
    @description = 'Des recettes. Partout. Tout plein!'
    @recipes = Recipe.find(:all, :order => "id desc", :limit => 3).reverse
  end

  def credits
    @title = 'credits'
    @description = 'Un grand merci à toi, lecteur.'
  end
  
end
