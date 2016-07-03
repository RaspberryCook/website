class IngredientsController < ApplicationController
  before_filter :authenticate, :only =>  [:destroy , :update , :edit ,:add]
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  autocomplete :ingredients , :name , :full => true

  def index
    @title = 'Ingredients'
  end


  def search 
    @title = 'recherche ingredients'
    @products = Ingredient.find params[:ingredient]
  end

  

end
