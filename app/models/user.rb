require 'digest'

class User < ActiveRecord::Base
	attr_accessible :nom, :email, :password, :password_confirmation
	attr_accessor :password
	has_many :recipes , :dependent => :destroy

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email , 
		:presence 	=> true ,
		:format 		=> { :with => email_regex },
		:uniqueness => { :case_sensitive => false }

	validates :nom , 
		:presence 	=> true ,
		:length 		=> { :maximum => 50 }

	validates :password, 
		:presence     => true,
		:confirmation => true,
		:length       => { :within => 6..40 }

	before_save :encrypt_password

	public

		def has_password?(password_sent)
			return self.encrypted_password == encrypt(password_sent)
		end

		def self.authenticate(email, submitted_password)
			user = find_by_email(email)
			return nil if user.nil?
			return user if user.has_password?(submitted_password)
		end

		def self.authenticate_with_salt (id , cookie_salt )
			user = find_by_id(id)
			(user && user.salt == cookie_salt ) ? user : nil
		end

	private

		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt (self.password)
		end

		def encrypt(string)
			return string
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end

end
