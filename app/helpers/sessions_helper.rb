# Helper user in all views to check if someone is logged
module SessionsHelper

	# Check if someone is logged in
	#
	# @return [Boolean] as true if someone is logged
	def signed_in?
		return true if  current_user else false
	end

	# Check if the curentuser correspond to one user
	#
	# @param user [User] as user to compare at current user
	# @return [Boolean] as true if given user correspond to current user
	def current_user? user
		user == current_user
	end


	# Only for the redirection in case of try to access on bad sheets
	def deny_access
		store_location
		redirect_to signin_path, :notice => "Please login to access on this sheet."
	end


end
