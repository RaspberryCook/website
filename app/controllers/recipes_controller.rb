class RecipesController < ApplicationController
	before_filter :authenticate, :only =>  [:destroy , :update , :edit ,:add, :create]
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
		@recipes = Recipe.paginate(:page => params[:page]).order('id DESC')
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
		@recipes = Recipe.search params[:recipe] , params[:ingredients] , params[:page]
	end


	# function to vote on a recipe with : http://localhost:3000/recipes/vote?id=93&value=1
	def vote
		#check before if the user can't try to send bad value
		if [-1 , 1 ].include? params[:value].to_i
			new_vote = Vote.new user_id: 1, recipe_id: params[:id], value: params[:value]
			new_vote.save
			respond_to do |format|
				format.js #{ render nothing: true }
			end

		else
			redirect_to root_path , :notice => "Petit-coquin!"
		end


	end


  	private
		def authenticate
			redirect_to signup_path , :notice => "Connectez-vous" unless current_user
		end

		def check_recipe_owner
			@recipe = Recipe.find(params[:id])
			redirect_to root_path , :notice => "Petit-coquin!" unless current_user == @recipe.user
		end

end
