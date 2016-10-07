class Comment < ActiveRecord::Base
 	belongs_to :user #association avec la table des utilisateurs
 	belongs_to :recipe #association avec la table des utilisateurs

 	acts_as_readable :on => :created_at # for use of unread gem


 	after_create :mark_read

 	private

 	def mark_read
 		User.where.not(id: self.user_id, id: self.recipe.user_id).each{|user|
 			self.mark_as_read! :for => user
 		}

 	end

end
