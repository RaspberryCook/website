class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :recipe

	attr_accessible :value, :user_id, :recipe_id


end
