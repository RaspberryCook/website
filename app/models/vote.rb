class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :recipe

	attr_accessible :value, :user_id, :recipe_id

	acts_as_readable :on => :created_at # for use of unread gem


end
