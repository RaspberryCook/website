class UsersController < ApplicationController
	before_filter :authenticate, :only => [:index , :edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,   :only =>  :destroy

	def show
		@user = User.find(params[:id])
		@title = @user.nom

		@recipes = @user.recipes.paginate(:page => params[:page]).order('id DESC')
	end

	def new
		@user = User.new
		@title = "S'inscrire"
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome!"
			redirect_to @user
		else
			@title = "Inscription"
			render 'new'
		end
	end

	def index
		@title = 'Index'
		@users = User.paginate(:page => params[:page])
	end

	def edit
		@title = 'Edit'
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profil mis a jour"
			redirect_to @user
		else
			@title = "Editer profil"
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

end
