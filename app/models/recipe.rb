class Recipe < ActiveRecord::Base
 	attr_accessible :name , :description , 
 		:ingredients , :steps , 
 		:category , :season , 
 		:t_baking , :t_cooling , :t_cooking ,:t_rest ,
 		:image

 	belongs_to :user  #association avec la table des utilisateurs
 	
 	mount_uploader :image , ImageUploader

	validates :name , 
		:presence 	=> true ,
		:uniqueness => { :case_sensitive => false }

end
