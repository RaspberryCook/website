class PagesController < ApplicationController
  
  def home
    @description = 'Des recettes. Partout. Tout plein!'
    @recipes = Recipe.find(:all, :order => "id desc", :limit => 3).reverse
  end

  def credits
    @title = 'credits'
    @description = 'Un grand merci à toi, lecteur.'
  end


  def feeds
    @title = 'actualités'
    @description = 'Tout ce que vous n\'avez pas ecore vu'
  end
  
end
