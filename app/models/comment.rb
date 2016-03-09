class Comment < ActiveRecord::Base
 	belongs_to :user #association avec la table des utilisateurs
 	belongs_to :recipe #association avec la table des utilisateurs

 	public 

 	def self.user_exist? user_id
 		result = self.where 'user_id' => user_id

 		if result = nil
 			false
 		else
 			true
 		end
 	end

end
