class Recipe < ActiveRecord::Base
 	attr_accessible :name , :description , 
 		:ingredients , :steps , 
 		:category , :season , 
 		:t_baking , :t_cooling , :t_cooking ,:t_rest ,
 		:image

 	belongs_to :user
	has_many :comments , :dependent => :destroy


 	mount_uploader :image , ImageUploader

 	self.per_page = 20

	validates :name , 
		:presence 	=> true ,
		:uniqueness => { :case_sensitive => false }

	def self.search name
		self.where( 'name LIKE ?' , "%#{name}%").all
	end

end
