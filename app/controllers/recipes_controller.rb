class RecipesController < ApplicationController
	before_filter :authenticate, :only =>  [:destroy , :update , :edit ,:add]
	before_filter :check_recipe_owner, :only =>  [:destroy , :update , :edit]


	#for autocomplete ingredients
	#autocomplete :ingredient, :name

	def show
		@recipe = Recipe.find(params[:id])
		@comment = Comment.new
		@title = @recipe.name
	end

	def new
		@titre = "nouvelle recette"
		@recipe = Recipe.new
	end

	def edit
		@title = 'editer recette'
		@recipe = Recipe.find(params[:id])
	end

	def create
		@recipe = current_user.recipes.create(params[:recipe])
		if @recipe.save
			flash[:success] = "huuummm! Dites nous en plus!"
	    	redirect_to edit_recipe_path(@recipe)
	    else
			@titre = "nouvelle recette"
	    	render 'new'
	    end
	end

  	def index
  		@title = "recettes"
  		@recipes = Recipe.paginate(:page => params[:page])
  	end

  	def destroy
  		# todo:add an identification
		Recipe.find(params[:id]).destroy
		flash[:success] = 'recette supprimee'
		redirect_to recipes_index_path
	end

	def update
		@recipe = Recipe.find(params[:id])
	    if @recipe.update_attributes(params[:recipe])
	      flash[:success] = "Recette mise a jour"
	      redirect_to @recipe
	    else
	      @title = "Editer"
	      render 'edit'
	    end
	end

	def save
		@recipe = Recipe.find(params[:id])
		html = render_to_string(:action => 'save', :encoding => "UTF-8" , :layout => false)
		doc = PDFKit.new( html )
		send_data( doc.to_pdf , 
		    :filename => "#{@recipe.name}.pdf", 
		    :disposition => 'attachment') 
	end


	def search
		@title = "rechercher une recette"
		@searched_terms = params[:recipe]
		@recipes = Recipe.search @searched_terms , params[:page]
	end


  	private
	  	def authenticate
	      redirect_to signup_path , :notice => "Connectez-vous" unless current_user
	    end

	    def check_recipe_owner
	    	@recipe = Recipe.find(params[:id])
	      	redirect_to root_path , :notice => "Petit-coquin!" unless current_user == @recipe.user
	    end

	    def recipe_search_params
	      params.require(:recipe).permit(:name)
	    end
end
