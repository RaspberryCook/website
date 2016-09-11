class Comment < ActiveRecord::Base
 	belongs_to :user #association avec la table des utilisateurs
 	belongs_to :recipe #association avec la table des utilisateurs

end
