class Vote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	belongs_to :answer
	belongs_to :user
	validates :user_id, uniqueness: { scope: :answer_id }
end

