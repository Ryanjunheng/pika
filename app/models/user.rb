require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt

	has_secure_password
	# This is Sinatra! Remember to create a migration!
	has_many :questions
	has_many :answers
	validates :username, uniqueness: true, length: { maximum: 64 }
	validates :email, uniqueness: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
	
end
