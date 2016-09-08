class Recipe < ActiveRecord::Base
	before_save :set_default_time

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
	has_many :votes , :dependent => :destroy


	mount_uploader :image , ImageUploader

	self.per_page = 20

	validates :name , 
		:presence 	=> true 

	def self.search name , ingredients , season, type, page
		# set ALL match for `type` & `season` if user don't care
		season = '%' if season == 'Toutes' or not season
		type = '%' if type == 'Toutes' or not type
		# make search
		self.where( 'name LIKE ? AND ingredients LIKE ? AND season LIKE ? AND rtype LIKE ?' , 
			"%#{name}%", "%#{ingredients}%" , season, type)
			.paginate( :page => page ).order('id DESC')
	end


	# copy the current recipe to a new user
	def fork(new_user_id)
		forked_recipe = self.dup
		forked_recipe.root_recipe_id = self.id
		forked_recipe.user_id = new_user_id
		return forked_recipe
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



	# copyt the current recipe to a new user
	def forked_recipes
		return Recipe.where(root_recipe_id: self.id ).order( :variant_name )
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
