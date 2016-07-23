class RecipesController < ApplicationController
	before_filter :authenticate, :only =>  [:destroy , :update , :edit ,:add, :create, :vote]
	before_filter :check_recipe_owner, :only =>  [:destroy , :update , :edit]


	#for autocomplete ingredients
	#autocomplete :ingredient, :name

	def show
		@recipe = Recipe.find(params[:id])
		@comment = Comment.new
		@title = @recipe.name
	end

	def new
		@title = "nouvelle recette"
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
		@title = "save recipe"
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

			# search if another vote exists
			vote = Vote.where( user_id: current_user.id , recipe_id: params[:id]).first
			filename = nil

			# if vote exist, we update it or send a warkning if is strickly the same
			if vote
				if vote.value == params[:value].to_i
					filename = 'vote_exists.js.erb' 
				else
					vote.value = params[:value].to_i
					filename = 'vote_updated.js.erb' 
				end

			# if vote don't exist, I create it
			else
				vote = current_user.votes.create user_id: 1, recipe_id: params[:id], value: params[:value]
			end

			# check if the save method work and send js.erb file as response
			if vote.save
				respond_to do |format|
					format.js { render filename}
				end
			else
				respond_to do |format|
					format.js { render 'vote_failed.js.erb'}
				end
			end


		else
			redirect_to root_path , :notice => "Petit-coquin!"
		end
	end




	def fork
		if request.get?
			# display a message to confirm
		elsif request.post?
			# create the copy
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
