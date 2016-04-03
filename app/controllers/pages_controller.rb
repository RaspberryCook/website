class PagesController < ApplicationController
  def home
		@title = 'home'
		@recipes = Recipe.find(:all, :order => "id desc", :limit => 5).reverse
  end

  def infos
		@title = 'infos'
  end

  def credits
		@title = 'credits'
  end
  
end
