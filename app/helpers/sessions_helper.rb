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


end
