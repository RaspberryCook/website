require 'recipe_scraper'
require 'open-uri'

# Recipe represent a delicious recipe posted on raspberry-cook.fr
#
# @attr name [String] the name of the recipe
# @attr description [String] the description of the recipe
# @attr ingredients [String] ingredients needed for the recipe
# @attr steps [String] steps to create the recipe
# @attr season [String] season to cook recipe
# @attr t_baking [DateTime] Baking time needed
# @attr t_cooling [DateTime] Cooling time needed
# @attr t_cooking [DateTime] Cooking time needed
# @attr t_rest [DateTime] Rest time needed
# @attr image [String] Url of picture
# @attr root_recipe_id [Integer] Id of original recipe
# @attr variant_name [String] name of the variant
# @attr rtype [String] Type of the recipe
#
# @attr user [User] as owner of recipe
# @attr comments [Array<Comment>] comments owned by recipe
class Recipe < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save :set_default_time

  attr_accessible :name, :description, :ingredients, :steps, :season,
    :t_baking, :t_cooling, :t_cooking, :t_rest,
    :baking, :cooling, :cooking, :rest,
    :image, :root_recipe_id, :variant_name, :rtype, :tags

  belongs_to :user
  has_many :comments , :dependent => :destroy
  has_many :views , :dependent => :destroy
  has_and_belongs_to_many :allergens

  mount_uploader :image , ImageUploader

  validates :name , :presence   => true
  acts_as_readable :on => :created_at # for use of unread gem

  self.per_page = 20
  # Availables types of recipe
  @@types = ['Toutes', 'Entrée', 'Plat', 'Dessert', 'Cocktail', 'Apéritif']
  # Availables seasons for a  recipe
  @@seasons = ['Toutes', 'Printemps', 'Eté', 'Automne', 'Hiver']
  # Time zero represent zero value for a task
  ZERO_TIME = DateTime.new 2000, 01, 01, 00, 00, 00


  TIME_LABELS = {
    baking: 'préparation', cooling: 'refrigération', cooking: 'cuisson', rest: 'repos'
  }

  # Get a given number of record
  #
  # @param number [Integer]
  # @yield [ActiveRecord::Base] as Recipes corresponding to params
  # @return [Array] list conatining recipes if no block given
  def self.random number
    count = self.count
    if block_given?
      number.times { yield self.offset(rand(count)).first}
    else
      recipes = []
      number.times { recipes << self.offset(rand(count)).first}
      return recipes
    end
  end


  # Get most viewed
  #
  # @param number [Integer]
  # @yield [ActiveRecord::Base] as Recipes corresponding to params
  # @return [Array] list conatining recipes if no block given
  def self.most_viewed number
    recipes = []
    Recipe.joins(:views).group('views.recipe_id').order('count_recipe_id desc').count('recipe_id').each do |id, count|
      number -= 1
      recipes << Recipe.find(id)
      return recipes if number == 0
    end
  end


  # search all recipes given by a search query params
  #
  # @param params [Hash] as GET params
  # @return [ActiveRecord::Base] as Recipes corresponding to params
  def self.search params

    sql_query_parts = []
    params_query = []

    # add all name exploded
    if params.has_key?(:name) and params[:name] != ''
      name_query_part = ''
      params[:name].split(' ').each do |part_name|
        name_query_part +=  ' name LIKE ? OR ingredients LIKE ? AND '
        params_query.push "%#{part_name}%"
        params_query.push "%#{part_name}%"
      end
      name_query_part.chomp! 'AND '
      # surround with ()
      sql_query_parts.push "(#{name_query_part})"
    end

    # add seasons
    if params.has_key?(:season) and not params[:season] == 'Toutes'
      sql_query_parts.push "( season LIKE ? )"
      params_query.push params[:season]
    end

    # add type
    if params.has_key?(:type) and not params[:type] == 'Toutes'
      sql_query_parts.push "( rtype LIKE ? )"
      params_query.push params[:type]
    end

    # add allergens
    if params.has_key?(:allergens)
      params['allergens'].each_key do |allergen_id|
        sql_query_parts.push "( allergens_recipes.allergen_id = ? )"
        params_query.push allergen_id
      end
    end

    # create query and add ask database
    sql_query = sql_query_parts.join ' AND '

    self.joins(:allergens)
      .where(sql_query , *params_query)
      .group(:id)
      .paginate( :page => params[:page] ).order('id DESC')
  end


  # Create a recipe from a marmiton url
  #
  # @param url [String] as url recipe
  # @param user_id [Integer] as id of the User creator of the recipe
  # @return [Recipe] as recipe created
  def self.import url, user_id
    # get  data from url
    marmiton_recipe = RecipeScraper::Recipe.new url
    marmiton_recipe_data = marmiton_recipe.to_hash
    # create recipe
    new_recipe = Recipe.new
    new_recipe.name = marmiton_recipe_data[:title]
    new_recipe.ingredients = marmiton_recipe_data[:ingredients].join "\r\n"
    new_recipe.steps = marmiton_recipe_data[:steps].join "\r\n"
    cooking_minutes = marmiton_recipe_data[:cooktime].to_i
    baking_minutes = marmiton_recipe_data[:preptime].to_i
    new_recipe.t_cooking = ZERO_TIME.advance minutes: cooking_minutes
    new_recipe.t_baking   = ZERO_TIME.advance minutes:  baking_minutes
    new_recipe.user_id = user_id


    if marmiton_recipe_data[:image]
      extention = marmiton_recipe_data[:image].split('.').last

      open("/tmp/image_from_marmiton.#{extention}", 'wb') do |file|
        file << open(marmiton_recipe_data[:image]).read
        new_recipe.image = file
      end
    end

    if new_recipe.save
      return new_recipe
    else
      raise 'Something goes wrong in fetching data from marmiton.org'
    end
  end


  # Type of of recipes ('Entrée', 'Plat', etc..)
  #
  # @return [Array] as types
  def self.types
    return @@types
  end


  # Seasons ('Toutes', 'Printemps', etc..)
  #
  # @return [Array] as seasons
  def self.seasons
    return @@seasons
  end



  # Copy the recipe from the user to a new user
  #
  # @param new_user_id [Integer] as id of the user owner of the new recipe
  # @return [Recipe] as recipe created
  def fork new_user_id
    forked_recipe = self.dup
    forked_recipe.root_recipe_id = self.id
    forked_recipe.user_id = new_user_id
    return forked_recipe
  end



  # Get the formatted name for the recipe (add variant name if forked recipe)
  #
  # @return [String]
  def pretty_name
    self.variant_name ? "%s - %s " % [  self.name , self.variant_name] : self.name
  end


  # Get the average rate of this recipe
  #
  # @return [Integer] as rate
  def rate
    rates = []
    self.comments.each{|com| rates.append com.rate}
    return rates.size > 0 ? rates.reduce(:+) / rates.size.to_f : 0
  end


  # Check if recipe is original or is a copy of another
  #
  # @return [Bollean] as true if it's a copy
  def forked?
    return self.root_recipe_id != 0
  end



  # Get the original recipe if this is a copy
  #
  # @return [Recipe] as original recipe or self if it's the original
  def root_recipe
    if self.root_recipe_id != 0
      return Recipe.find self.root_recipe_id
    else
      return self
    end
  end


  # search all recipes given by a search query params
  #
  # @return [ActiveRecord::Base] as Recipes corresponding to params
  def forked_recipes
    return Recipe.where(root_recipe_id: self.id ).order( :variant_name )
  end


  # get image_url :thumb
  # if the recipe havn't picture and she's forked , we get the parent image
  #
  # @return [String] as url of the image
  def true_thumb_image_url
    bd_image = self.image_url(:thumb)

    if self.forked? and not picture_exist? bd_image
      return self.root_recipe.image_url(:thumb)
    else
      return bd_image
    end
  end


  # get image_url
  # if the recipe havn't picture and she's forked , we get the parent image
  #
  # @return [String] as url of the image
  def true_image_url
    bd_image = self.image_url

    if self.forked? and not picture_exist? bd_image
      return self.root_recipe.image_url
    else
      return bd_image
    end
  end

  # Return true if user has set an image for this recipe
  #
  # @return [Boolean]
  def has_image?
    return  true_image_url != ImageUploader.new.default_url
  end


  # count the total vote for this recipe
  #
  # @return [Integer] ad count
  def note
    note = 0
    self.votes.each do |vote|
      note += vote.value
    end
    return note
  end


  # Add view on recipe
  #
  # @param user_id [Integer]
  # @return [View] as view object added
  def add_view user_id=nil
    View.create recipe_id: self.id, user_id: user_id
  end


  # Get nouber of this recipe has been counted
  #
  # @return [Integer] as count
  def count_views
    self.views.count
  end

  # Return the sum of the time
  #
  # @return [Integer]
  def sum_of_times
    sum = 0
    [:baking, :cooling, :cooking, :rest].each do |time|
      sum += self.send time
    end
    return sum
  end

  # Return a percentage of time according to the total sum
  #
  # @param time [string] as time name
  # @return [float]
  def percentage_time time
    return (self.send(time.to_s).to_f / sum_of_times.to_f) * 100
  end

  private


  # set default time on t_baking, t_cooling, t_cooking, t_rest if not already set
  def set_default_time
    zero_time = Time.new 2000, 1, 1, 1, 0, 0
    [:t_baking, :t_cooling, :t_cooking, :t_rest].each { |t_time|
      self.send("#{t_time}=".to_sym, zero_time) unless self.send(t_time).present?
    }
  end


  # Ensure to picture exists
  #
  # @param picture_url [String] as url to check
  # @return [Boolean] if picture exists
  def picture_exist? picture_url
    absolute_path =  File.join Rails.root , 'public', picture_url
    return File.file? absolute_path
  end


  # check if we need to generate slug for this model
  #
  # @return [Boolean] if picture exists
  def should_generate_new_friendly_id?
    name_changed? || super
  end


end
