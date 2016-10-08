class RecipesController < ApplicationController
	before_filter :authenticate, :only =>  [:destroy , :update , :edit ,:new, :add, :create, :fork]
	before_filter :check_recipe_owner, :only =>  [:destroy , :update , :edit]


	#for autocomplete ingredients
	#autocomplete :ingredient, :name

	def show
		@recipe = Recipe.find(params[:id])
		@comment = Comment.new
		@title = @recipe.name
		if @recipe.description
			@description = 'Une delicieuse recette de %s.' % @recipe.user.firstname
		else
			@description = @recipe.description
		end

		if current_user
			@recipe.mark_as_read! :for => current_user
			@recipe.comments.each { |com| com.mark_as_read! :for => current_user }
		end
	end

	def new
		@recipe = Recipe.new
		@title = "nouvelle recette"
		@description = 'Composez votre nouvelle recettes.'
	end

	def edit
		@recipe = Recipe.find(params[:id])
		@title = 'editer "%s" recette' % @recipe.name
		@description = 'Editer la recette %s (pour la rendre encore meilleure).' % @recipe.name
	end

	def create
		@recipe = current_user.recipes.create(params[:recipe])
		if @recipe.save
			flash[:success] = "huuummm! Dites nous en plus!"
			redirect_to edit_recipe_path(@recipe)
		else
			@title = "nouvelle recette"
			flash[:error] = "Une erreure est survenue, veuillez éssayer à nouveau"
			render 'new'
		end
	end

	def index
		@title = "liste des recettes"
		@description = 'Beaucoup d\'excllentes recettes (oui, oui).'
		@recipes = Recipe.paginate(:page => params[:page]).order('id DESC')
	end

	def destroy
  		# todo:add an identification
		Recipe.find(params[:id]).destroy
		flash[:success] = 'recette supprimee'
		redirect_to  recipes_path 
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
		@description = 'Cherchez votre chemin parmis nos plus belles recettes.'
		@recipes = Recipe.search params[:recipe], params[:ingredients], params[:season], params[:type], params[:page]
	end



	# a fork is a copy of the current recipe
	def fork
		if request.get?
			@recipe = Recipe.find(params[:id])
			@title = "Variante de %s" % @recipe.name
			@description = "Créer une variante de %s (sans gluten, version light, etc..)" % @recipe.name
		elsif request.post?
			recipe = Recipe.find params[:id]
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
			@recipe = Recipe.find(params[:id])
			redirect_to root_path , :notice => "Petit-coquin!" unless current_user == @recipe.user
		end

end
