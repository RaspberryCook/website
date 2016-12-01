# Application controller is the parent class for all controllers
# to share code between all of them
class ApplicationController < ActionController::Base
	protect_from_forgery

	private

	def current_user_session
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
	end

	def current_user
		return @current_user if defined?(@current_user)
		@current_user = current_user_session && current_user_session.user
	end

	helper_method :current_user_session, :current_user

	private
	
	def authenticate
		redirect_to signup_path , :notice => "Connectez-vous" unless current_user
	end
end
