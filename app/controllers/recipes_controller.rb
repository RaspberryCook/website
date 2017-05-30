require 'uri'

# Recipe controller permit to CRUD recipes
class RecipesController < ApplicationController
	before_filter :authenticate, :only =>  [:destroy , :update , :edit ,:new, :add, :create, :fork, :import]
	before_filter :check_recipe_owner, :only =>  [:destroy , :update , :edit]

	# GET /recipes/1
	def show
		session['recipes_viewed'] = 0 unless session.has_key? 'recipes_viewed'

		# if user is connected or user have consulted less than 5 recipes
		if current_user or session['recipes_viewed'] < 3

			@recipe = Recipe.friendly.find params[:id]
			@recipe.add_view

			@recipe.save  unless @recipe.slug?

			respond_to do |format|
				format.json { render json: @recipe  }
				format.html {
					@comment = Comment.new
					@title = @recipe.name

					if @recipe.user
						@description = 'Une delicieuse recette de %s.' % @recipe.user.firstname
					else
						@description = @recipe.description
					end

					if current_user
						@recipe.mark_as_read! :for => current_user
						@recipe.comments.each { |com| com.mark_as_read! :for => current_user }

					else current_user
						flash[:info] = "%s ou %s pour faire vivre Raspberry Cook <3." % [view_context.link_to("Connectez-vous", signin_path), view_context.link_to("créez un compte", signup_path)]
						session['recipes_viewed'] += 1
					end
					render "show"
				}
			end

		else
			flash[:warning] = "Vous avez déjà consulté %s recettes. Vous devez vous %s, %s ou bien revenir plus tard." % [
				session['recipes_viewed'] ,
				view_context.link_to("connecter", signin_path),
				view_context.link_to("créer un compte", signup_path)
			]
			redirect_to signin_path
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
		@recipe = Recipe.friendly.find(params[:id])
		@title = 'Editer "%s" recette' % @recipe.name
		@description = 'Editer la recette %s (pour la rendre encore meilleure).' % @recipe.name
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

		if search_params.count
			@title = "Résultats de votre recherche %s" % [search_params.values.join(' ')]
			@description = 'Beaucoup d\'excllentes recettes (oui, oui).'
		else
			@title = "liste des recettes"
			@description = 'Beaucoup d\'excllentes recettes (oui, oui).'
		end

		@recipes = Recipe.search params
		respond_to do |format|
			format.html { render "index" }
			format.json { render json: @recipes  }
		end

	end


	# DELETE /recipes/1
	def destroy
		Recipe.friendly.find(params[:id]).destroy
		flash[:success] = 'recette supprimée'
		redirect_to  recipes_path
	end


	# PATCH/PUT /recipes/1
	def update
		@recipe = Recipe.friendly.find(params[:id])
		if @recipe.update_attributes(params[:recipe])
			flash[:success] = "Recette mise a jour"
			redirect_to @recipe
		else
			@title = "Editer"
			render 'edit'
		end
	end


	# GET /recipes/1/save
	# Generate a PDF document about this recipe and serve it to user
	def save
		@title = "save recipe"
		@recipe = Recipe.friendly.find(params[:id])
		html = render_to_string(:action => 'save', :encoding => "UTF-8" , :layout => false)
		doc = PDFKit.new( html )
		send_data( doc.to_pdf ,
			:filename => "#{@recipe.name}.pdf",
			:disposition => 'attachment')
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
				flash[:success] = "Forked successfull!"
				redirect_to edit_recipe_path(forked_recipe)
			else
				flash[:success] = "Forked successfull!"
				redirect_to recipe_path(recipe)
			end
		end
	end


	private

		def check_recipe_owner
			@recipe = Recipe.friendly.find(params[:id])
			redirect_to root_path , :info => "Petit-coquin!" unless current_user == @recipe.user
		end


		def search_params
			params.permit(:name, :ingredients, :type, :season)
		end

end
