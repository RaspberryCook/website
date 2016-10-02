class Comment < ActiveRecord::Base
 	belongs_to :user #association avec la table des utilisateurs
 	belongs_to :recipe #association avec la table des utilisateurs

 	acts_as_readable :on => :created_at # for use of unread gem


 	after_create :mark_unread

 	private

 	def mark_unread
 		Comment.unread_by(self.recipe.user) unless self.user == self.recipe.user
 	end

end
