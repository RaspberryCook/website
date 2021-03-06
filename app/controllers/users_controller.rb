# User controller permit to consult data about an user and
# create an account on Raspberry Cook
class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only =>  :destroy


  # GET /users/1
  def show
    @user = User.includes(:recipes, :comments).find(params[:id])
    @recipes = @user.recipes.paginate(:page => params[:page]).order('id DESC')
    @title = @user.username
    @description = "Tout les informations à propos de %s." % @user.firstname
  end


  # GET /users/new
  # GET /signup
  def new
    # redirect user to his page if he's already connected
    if current_user
      redirect_to current_user
    else
      @user = User.new
      @title = "S'inscrire"
      @description = "S'inscrire sur Raspberry Cook."
    end
  end


  # POST /users
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


  # GET /users
  def index
    @title = 'Index'
    @description = "Toute la communauté du seigneur des recettes."
    @users = User.paginate(:page => params[:page])
  end


  # GET /users/1/edit
  def edit
    @title = 'Editer vos infos'
    @description = "Dites nous en un peu plus sur vous. Votre p'tit firstname, toussa, toussa."
    @user = User.find(params[:id])
  end


  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])

    if @user.update_attributes users_params_update
      flash[:success] = "Profil mis a jour"
      redirect_to @user
    else
      flash[:warning] = "Une erreur est survenue"
      redirect_to edit_user_path(@user)
    end
  end


  # DELETE /users/1
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path
  end



  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path , :info => "petit coquin!" unless current_user == @user
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
