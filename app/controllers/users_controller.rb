class UsersController < ApplicationController
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,   :only =>  :destroy

	def show
		@user = User.find(params[:id])
		@recipes = @user.recipes.paginate(:page => params[:page]).order('id DESC')
		@title = @user.username
		@description = "Tout les informations à propos de %s." % @user.firstname
	end

	def new
		@user = User.new
		@title = "S'inscrire"
		@description = "S'inscrire sur Raspberry Cook."
	end

	def create
		@user = User.new users_params
		if @user.save
			@user_session = UserSession.new(users_params)
			flash[:success] = "Welcome!"
			redirect_to @user
		else
			@title = "Inscription"
			@description = "S'inscrire sur Raspberry Cook."
			render 'new'
		end
	end

	def index
		@title = 'Index'
		@description = "Toute la communauté du seigneur des recettes."
		@users = User.paginate(:page => params[:page])
	end

	def edit
		@title = 'editer vos infos'
		@description = "Dites nous en un peu plus sur vous. Votre p'tit firstname, toussa, toussa."
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes users_params_update
			flash[:success] = "Profil mis a jour"
			redirect_to @user
		else
			# puts Rails.logger.info(@user.errors.messages.inspect)
			flash[:error] = "Une erreur est survenue"
			redirect_to edit_user_path(@user)
		end
	end

	# def destroy
	# 	User.find(params[:id]).destroy
	#	flash[:success] = 'User deleted'
	#	redirect_to users_path
	# end



	private

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_path , :notice => "petit coquin!" unless current_user == @user
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

		def users_params
			params.require(:user).permit(:email, :username, :firstname, :lastname, :password, :password_confirmation)
		end

		def users_params_update
			if params['user']['password_confirmation'].present?
				return params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
			else
				params['user']['password_confirmation'] = params['user']['password']
				return params.require(:user).permit(:email, :firstname, :lastname, :password)
			end
		end


end
