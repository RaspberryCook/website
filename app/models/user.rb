class User < ActiveRecord::Base
	attr_accessible :username, :firstname, :lastname, :email, :password, :password_confirmation, :crypted_password
	has_many :recipes , :dependent => :destroy
	has_many :comments , :dependent => :destroy

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email , 
		:presence => true ,
		:format => { :with => email_regex },
		:uniqueness => { :case_sensitive => false }

	validates :username , :presence  => true , :uniqueness => true
	validates :firstname , :presence => true , :length  => { :maximum => 50 }
	validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }

	acts_as_authentic do |c|
		c.crypto_provider = Authlogic::CryptoProviders::Sha512
		c.validate_email_field = true
	end

	acts_as_reader

	public

		def complete_name
			return '%s %s' % [ self.lastname, self.firstname ]
		end


		# return user's comment on the specified recipe id
		def comment_on_recipe recipe_id
			comment = Comment.where( :user_id => self.id , :recipe_id => recipe_id ).first
			comment = Comment.new if comment.blank?
			return comment
		end

		# compare secure password from password sent
		def has_password?(password_sent)
			return self.password == encrypt(password_sent)
		end

		# connect user
		def self.authenticate(email, submitted_password)
			user = find_by_email(email)
			return nil if user.nil?
			return user if user.has_password?(submitted_password)
		end

		# return rank of this user nRecipes*10+nComments
		def rank
			self.comments.count + self.recipes.count*5
		end

	private


		def users_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

end
