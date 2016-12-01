# Session controller allow user to signin/signout on Raspberry Cook
class SessionsController < ApplicationController


	# GET /sessions/new
	# GET /signin
	def new
		@title = 'signin'
		@description = "Accéder à des milliers, des million, des milliards de recettes"
		@user_session = UserSession.new
	end


	# POST /sessions 
	def create
		@user_session = UserSession.new user_session_params

		if @user_session.save
			flash[:success] = "bienvenue #{current_user.firstname}!"
			redirect_to user_path( @user_session.user )
		else
			flash.now[:error] = "Combinaison Pseudo/Mot de passe invalide."
			puts @user_session.errors.full_messages.inspect
			@title = "S'identifier"
			@description = "se connecter sur un site qu'il est bien!"
			render 'new'
		end
	end


	# DELETE /sessions/1
	def destroy
		current_user_session.destroy
		redirect_to root_path , :success => "A bientot!"
	end


	private

	def user_session_params
		params.require(:sessions).permit(:email, :username, :password, :remember_me)
	end

end