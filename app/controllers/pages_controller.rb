class PagesController < ApplicationController
	before_filter :authenticate, :only =>  [:feeds]
	
	
	def home
		@description = 'Des recettes. Partout. Tout plein!'
		@recipes = Recipe.find(:all, :order => "id desc", :limit => 3).reverse
	end

	def credits
		@title = 'credits'
		@description = 'Un grand merci à toi, lecteur.'
	end


	def feeds
		@title = 'actualités'
		@description = 'Tout ce que vous n\'avez pas ecore vu'
		@recipes_feeds = Recipe.unread_by(current_user).paginate(:page => params[:page]).order('id DESC')
		@unread_comments = current_user.unread_comments{|c|c}
	end
	
end
