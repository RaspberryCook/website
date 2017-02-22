# Comment is a text posted by a User on a Recipe
#
# @attr user [User] Owner of this comment
# @attr recipe [Recipe] Recipe concerned by this comment
class Comment < ActiveRecord::Base
  
 	belongs_to :user
 	belongs_to :recipe

 	acts_as_readable :on => :created_at # for use of unread gem
 	after_create :mark_read

 	private

  # mark this comment as read
 	def mark_read
 		User.where.not(id: self.recipe.user_id).each{|user|
 			self.mark_as_read! :for => user
 		}

 	end

end
