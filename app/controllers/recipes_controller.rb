require 'uri'

# Recipe controller permit to CRUD recipes
class RecipesController < ApplicationController
  before_filter :authenticate, only: [:destroy , :update , :edit ,:new, :add, :create, :fork, :import]
  before_filter :check_recipe_owner, only: [:destroy , :update , :edit]


  # GET /recipes/1
  def show
    @recipe = Recipe.includes(:allergens, :user, :views).friendly.find(params[:id])
    @recipe.add_view

    # regen slug if don't already set
    @recipe.save unless @recipe.slug?


    respond_to do |format|
      format.json { render json: @recipe  }
      format.html {
        @recipes = Recipe.random(3)
        @comment = Comment.new

        # CEO stuff
        @title = @recipe.name
        @jsonld = @recipe.to_jsonld

        if @recipe.user
          @description = 'Une delicieuse recette de %s.' % @recipe.user.firstname
        else
          @description = @recipe.description
        end

        @meta = @recipe.allergens.map{|allergen| allergen.name}.join(', ')

        if @meta
          @description += '(' + @meta  + ')'
        end


        if current_user
          @recipe.mark_as_read! :for => current_user
          @recipe.comments.each { |com| com.mark_as_read! :for => current_user }

        else current_user
          flash[:info] = "%s ou %s pour faire vivre Raspberry Cook <3." % [view_context.link_to("Connectez-vous", signin_path), view_context.link_to("créez un compte", signup_path)]
        end
        render "show"
      }
    end
  end


  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @title = "Créer une recette"
    @description = 'Composez votre nouvelle recettes.'
  end


  # GET /recipes/1/edit
  def edit
    @title = 'Editer "%s" recette' % @recipe.name
    @description = 'Editer la recette %s (pour la rendre encore meilleure).' % @recipe.name
    @allergens = Allergen.all
  end


  # POST /recipes
  def create
    name_sent = params[:recipe][:name]

    # we check before if the name sent is an url
    # if name_sent is an url, we try to import recipe from host
    if name_sent =~ URI::regexp
      begin
        # import from the url
        recipe_imported = Recipe.import name_sent, current_user.id
        redirect_to edit_recipe_path(recipe_imported)

      rescue ArgumentError
        flash[:warning] = "Cette URL n'est pas suportée par Raspberry Cook :("
        redirect_to new_recipe_path

      rescue Exception
        flash[:warning] = "Quelque chose a merdé :("
        redirect_to new_recipe_path
      end

    else
      # Create the recipe
      @recipe = current_user.recipes.create(params[:recipe])
      if @recipe.save
        flash[:success] = "huuummm! Dites nous en plus!"
        redirect_to edit_recipe_path(@recipe)
      else
        flash[:warning] = "Une erreur est survenue, veuillez essayer à nouveau"
        redirect_to new_recipe_path
      end
    end
  end


  # GET /recipes
  def index
    if search_params.count > 0
      @title = 'Résultats de votre recherche "%s"' % [search_params.values.join(' ')]
      @description = 'Beaucoup d\'excllentes recettes (oui, oui).'
    else
      @title = "liste des recettes"
      @description = 'Beaucoup d\'excllentes recettes (oui, oui).'
    end

    @recipes = Recipe.search params
    respond_to do |format|
      format.html {
        @jsonld = {
          "@context":"http://schema.org",
          "@type":"ItemList",
          "itemListElement": @recipes.map{|recipe| recipe.to_jsonld}
        } if @recipes
        render "index"
      }
      format.json { render json: @recipes  }
    end
  end


  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    flash[:success] = 'recette supprimée'
    redirect_to  recipes_path
  end


  # PATCH/PUT /recipes/1
  def update
    if @recipe.update_attributes recipe_params
      # we setup allergens
      if allergens_params = params['recipe']['allergens']
        @recipe.allergens = allergens_params.map do |allergen_id, checked|
          Allergen.find(allergen_id)
        end
      end
      flash[:success] = "Recette mise a jour"
      redirect_to @recipe
    else
      @title = "Editer"
      render 'edit'
    end
  end



  # GET /recipes/shuffle
  # get a random recipe and redirect user on this
  def shuffle
    offset = rand Recipe.count
    random  = Recipe.offset(offset).first
    flash[:success] = "Celle ci a l'air vraiment pas mal, régalez vous!"
    redirect_to recipe_path random
  end



  # GET/POST /recipes/1/fork
  # a fork is a copy of the current recipe
  def fork
    if request.get?
      @recipe = Recipe.friendly.find(params[:id])
      @title = "Variante de %s" % @recipe.name
      @description = "Créer une variante de %s (sans gluten, version light, etc..)" % @recipe.name
    elsif request.post?
      recipe = Recipe.friendly.find params[:id]
      forked_recipe = recipe.fork current_user.id

      if forked_recipe.save
        flash[:success] = "C'est maintenant votre recette, faites en ce que vous voulez!"
        redirect_to edit_recipe_path(forked_recipe)
      else
        flash[:danger] = "Une erreur est survenue!"
        redirect_to recipe_path(recipe)
      end
    end
  end


  private

  def check_recipe_owner
    @recipe = Recipe.friendly.find(params[:id])
    redirect_to root_path , info: "Petit-coquin!" unless current_user.id == @recipe.user_id
  end


  def recipe_params
    params.require(:recipe).permit(:variant_name, :description, :image, :tags, :rtype, :season, :cooking, :baking, :cooling, :rest, :ingredients, :steps, :allergens)
  end


  def search_params
    params.permit(:name, :ingredients, :type, :season)
  end

end
