class Recipe < ActiveRecord::Base
	before_save :set_default_time

	attr_reader :t_cooking

	attr_accessible :name , :description , 
		:ingredients , :steps  , :season , 
		:t_baking , :t_cooling , :t_cooking ,:t_rest ,
		:image,
		:root_recipe_id,
		:variant_name,
		:rtype

	# attr_reader :id

	belongs_to :user
	has_many :comments , :dependent => :destroy


	mount_uploader :image , ImageUploader

	self.per_page = 20

	validates :name , 
		:presence 	=> true 



 	acts_as_readable :on => :created_at # for use of unread gem

 	@@types = ['Entrée', 'Plat', 'Dessert', 'Cocktail', 'Apéritif']
 	@@seasons = ['Toutes', 'Printemps', 'Eté', 'Automne', 'Hiver']

 	# search all recipes given by a search query params
	def self.search params
		sql_query =  'name LIKE ?'
		params_query = [ "%#{params[:name]}%"]

		if params[:ingredients] and not params[:ingredients].empty?
			sql_query +=  ' AND ingredients LIKE ?'
			params_query.push "%#{params[:ingredients]}%"
		end

		if params.has_key?(:season) and not params[:season] == 'Toutes' 
			sql_query +=  'AND season LIKE ?'
			params_query.push params[:season] 
		end

		if params.has_key?(:type) and not params[:type] == 'Toutes' 
			sql_query +=  'AND rtype LIKE ?'
			params_query.push params[:type] 
		end

		self.where(sql_query , *params_query).paginate( :page => params[:page] ).order('id DESC')
	end


	def self.types
		return @@types
	end

	def self.seasons
		return @@seasons
	end



	# copy the current recipe to a new user
	def fork(new_user_id)
		forked_recipe = self.dup
		forked_recipe.root_recipe_id = self.id
		forked_recipe.user_id = new_user_id
		return forked_recipe
	end


	def rate
		rates = []
		self.comments.each{|com| rates.append com.rate}
		return rates.reduce(:+) / rates.size.to_f if rates.size > 0 else 0
	end



	def forked?
		return true  if self.root_recipe_id != 0 else return false
	end



	# return the origin recipe
	def root_recipe
		if self.root_recipe_id != 0
			return Recipe.find self.root_recipe_id
		else
			return self
		end
	end

	# copyt the current recipe to a new user
	def forked_recipes
		return Recipe.where(root_recipe_id: self.id ).order( :variant_name )
	end



	# get image_url :thumb
	# if the recipe havn't picture and she's forked , we get the parent image 
	def true_thumb_image_url
		bd_image = self.image_url(:thumb)

		if self.forked? and not picture_exist? bd_image
			return self.root_recipe.image_url(:thumb)
		else
			return bd_image
		end
	end

	# get image_url
	# if the recipe havn't picture and she's forked , we get the parent image 
	def true_image_url
		bd_image = self.image_url

		if self.forked? and not picture_exist? bd_image
			return self.root_recipe.image_url
		else
			return bd_image
		end
	end



	# count the total vote for this recipe
	def note
		note = 0
		self.votes.each do |vote|
			note += vote.value
		end
		return note
	end

	private

	# set default time on t_baking, t_cooling, t_cooking, t_rest if not already set
	def set_default_time

		zero_time = Time.new 2000, 1, 1, 1, 0, 0

		[:t_baking, :t_cooling, :t_cooking, :t_rest].each { |t_time|
			self.send("#{t_time}=".to_sym, zero_time) unless self.send(t_time).present?
		}
	end

	def picture_exist? picture_url
		absolute_path =  File.join Rails.root , 'public', picture_url
		return File.file? absolute_path
	end

end
