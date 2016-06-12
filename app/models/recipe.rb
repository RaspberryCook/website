class Recipe < ActiveRecord::Base
	attr_accessible :name , :description , 
		:ingredients , :steps , 
		:category , :season , 
		:t_baking , :t_cooling , :t_cooking ,:t_rest ,
		:image

	belongs_to :user
	has_many :comments , :dependent => :destroy
	has_many :votes , :dependent => :destroy


	mount_uploader :image , ImageUploader

	self.per_page = 20

	validates :name , 
		:presence 	=> true ,
		:uniqueness => { :case_sensitive => false }

	def self.search name , ingredients , page
		self.where( 'name LIKE ? AND ingredients LIKE ?' , "%#{name}%", "%#{ingredients}%").paginate( :page => page ).order('id DESC')
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
