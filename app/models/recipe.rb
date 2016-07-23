class Recipe < ActiveRecord::Base
	attr_accessible :name , :description , 
		:ingredients , :steps , 
		:category , :season , 
		:t_baking , :t_cooling , :t_cooking ,:t_rest ,
		:image,
		:root_recipe_id,
		:variant_name

	# attr_reader :id

	belongs_to :user
	has_many :comments , :dependent => :destroy
	has_many :votes , :dependent => :destroy


	mount_uploader :image , ImageUploader

	self.per_page = 20

	validates :name , 
		:presence 	=> true 

	def self.search name , ingredients , page
		self.where( 'name LIKE ? AND ingredients LIKE ?' , "%#{name}%", "%#{ingredients}%").paginate( :page => page ).order('id DESC')
	end


	# copyt the current recipe to a new user
	def fork(new_user_id)
		forked_recipe = self.dup
		forked_recipe.root_recipe_id = self.id
		forked_recipe.user_id = new_user_id
		forked_recipe.remove_image!
		return forked_recipe
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

end
