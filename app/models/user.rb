# user is someone abloe to connect on Raspberry Cook and CRUD a recipe or a comment
#
# @attr username [String] the username of this user: 'madeindjs'
# @attr firstname [String] the firstname of this user:
# @attr lastname [String] the lastname of this user
# @attr email [String] the email of this user
# @attr password [String] the password of this user
# @attr password_confirmation [String] the password confirmed by user
# @attr crypted_password [String] the password crypted
#
# @attr recipes [Array<Recipe>] as recipes owned by this user
# @attr comments [Array<Comment>] as comments owned by this user
class User < ActiveRecord::Base


  attr_accessible :username, :firstname, :lastname, :email,
    :password, :password_confirmation, :crypted_password
  

  has_many :recipes , :dependent => :destroy
  has_many :comments , :dependent => :destroy

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true , :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :username , :presence  => true , :uniqueness => true
  validates :firstname , :presence => true , :length  => { :maximum => 50 }
  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
    c.validate_email_field = true
  end

  acts_as_reader

  # Construct the complete name as "John Doe"
  #
  # @return [String] as complete name
  def complete_name
    return '%s %s' % [ self.lastname, self.firstname ]
  end


  # Get user's comment on the specified recipe id
  #
  # @param recipe_id [Integer] as Id of the recipe
  # @return [Comment] as comment founded
  def comment_on_recipe recipe_id
    comment = Comment.where( :user_id => self.id , :recipe_id => recipe_id ).first
    comment = Comment.new if comment.blank?
    return comment
  end


  # Check password equality with encrypt
  #
  # @param password_sent [String] as pasword sent by user
  # @return [Boolean] if password correspond
  def has_password? password_sent
    return self.password == encrypt(password_sent)
  end


  # Connect user to Rasberry-cook.fr
  #
  # @param email [String] as email sent by user
  # @param submitted_password [String] as pasword sent by user
  # @return [Boolean] as true if success
  def self.authenticate email, submitted_password
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end


  # Get rank of this user nRecipes*10 + nComments
  #
  # @return [Integer] as score
  def rank
    self.comments.count + self.recipes.count*5
  end

  # Generate an image source from an email
  #
  # @return [String] as image url
  def gravatar_url
    gravatar = Digest::MD5::hexdigest(self.email).downcase
    return "https://gravatar.com/avatar/#{gravatar}.png"
  end

  # Format to json_ld 
  #
  # @return [Hash]
  def to_jsonld
    {
      "@context" => "http://schema.org/",
      "@type": "Person",
      givenName: self.lastname,
      image: self.gravatar_url,
      url: Rails.application.routes.url_helpers.user_url(self.id)
    }
  end

end
