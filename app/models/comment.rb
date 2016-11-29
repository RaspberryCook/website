class Comment < ActiveRecord::Base

  # @association user [User] as owner of this comment
  # @association recipe [Recipe] as recipe concerned by this comment
 	belongs_to :user
 	belongs_to :recipe

 	acts_as_readable :on => :created_at # for use of unread gem
 	after_create :mark_read

 	private

  # mark this comment as read
 	def mark_read
 		User.where.not(id: self.user_id, id: self.recipe.user_id).each{|user|
 			self.mark_as_read! :for => user
 		}

 	end

end
