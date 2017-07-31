class Allergen < ActiveRecord::Base
  has_and_belongs_to_many :recipes

  # Get 
  def icon_url
    ApplicationController.helpers.image_url "allergens/#{self.icon}"
  end
end
