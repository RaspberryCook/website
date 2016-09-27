class UsersController < ApplicationController
	before_filter :authenticate, :only => [ :edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,   :only =>  :destroy

	def show
		@user = User.find(params[:id])
		@recipes = @user.recipes.paginate(:page => params[:page]).order('id DESC')
		@title = @user.firstname
		@description = "Tout les informations à propos de %s." % @user.firstname
	end

	def new
		@user = User.new
		@title = "S'inscrire"
		@description = "S'inscrire sur Raspberry Cook."
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			@user_session = UserSession.new(user_session_params)
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
		if @user.update_attributes(params[:user])
			flash[:success] = "Profil mis a jour"
			redirect_to @user
		else
			@title = "Editer profil"
			@description = "Dites nous en un peu plus sur vous. Votre p'tit firstname, toussa, toussa."
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = 'User deleted'
		redirect_to users_path
	end



	private

		def authenticate
			deny_access unless signed_in?
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_path , :notice => "petit coquin!" unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

		def users_params
			params.require(:user).permit(:email, :username, :firstname, :lastname, :password, :password_confirmation)
		end

		def user_session_params
			params.require(:user).permit(:email, :password, :remember_me)
		end

end
