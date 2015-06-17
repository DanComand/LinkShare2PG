class User < ActiveRecord::Base
	validates :email, :case_sensitive => false 
	has_secure_password
	has_many :bookmarks
end
