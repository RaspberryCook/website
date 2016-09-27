module SessionsHelper


	def signed_in?
		return true if  current_user else false
	end

	#check if the curentuser correspond to one user
	def current_user?(user)
		user == current_user
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


	#FRIENDLY-FORWADING
	def store_location
		session[:return_to] = request.fullpath
	end

	def clear_return_to
		session[:return_to] = nil
	end


end
