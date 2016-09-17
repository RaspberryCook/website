module SessionsHelper

	# PART OF THE CONNECTION SETUP
	def sign_in user
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	#check if the curentuser correspond to one user
	def current_user?(user)
		user == current_user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def current_user
		@current_user ||= user_from_remember_token
	end

	#ONLY FOR THE REDIRECTION IN CASE OF TRY TO ACCESS ON BAD SHEETS
	def deny_access
		store_location
		redirect_to signin_path, :notice => "Please login to access on this sheet."
	end

	#FRIENDLY-FORWADING
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end

	private

	def user_from_remember_token
		User.authenticate_with_salt(*remember_token)
	end

	def remember_token
		cookies.signed[:remember_token] || [nil, nil]
	end

	#FRIENDLY-FORWADING
	def store_location
		session[:return_to] = request.fullpath
	end

	def clear_return_to
		session[:return_to] = nil
	end


end
