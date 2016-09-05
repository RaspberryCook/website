class SessionsController < ApplicationController

  def new
    @title = 'signin'
    @description = "Accéder à des milliers, des million, des milliards de recettes"
  end


  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Combinaison Email/Mot de passe invalide."
      @title = "S'identifier"
      @description = ""
      render 'new'
    else
      sign_in user
      flash[:success] = "bienvenue #{current_user.nom}!"
			redirect_back_or user
    end
	end

  def destroy
    sign_out
    redirect_to root_path , :success => "A bientot!"
  end

end
