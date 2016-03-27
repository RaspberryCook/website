class Comment < ActiveRecord::Base
 	belongs_to :user #association avec la table des utilisateurs
 	belongs_to :recipe #association avec la table des utilisateurs

 	public 

 	def self.did_I_comment_this? user_id , recipe_id
 		#problem cauz we search on all database but we want searchonly on comments.recipe.user_id
 		#dont return a nill but a strange object

 		#self.exists? :user_id => user_id , :recipe_id => recipe_id 
 		comment = self.where( :user_id => user_id , :recipe_id => recipe_id ).first

 		comment = Comment.new if comment.blank?
 			

 		return comment

 	end

end
