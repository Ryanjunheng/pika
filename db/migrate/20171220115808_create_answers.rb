class CreateAnswers < ActiveRecord::Migration[5.0]
	def change
		create_table :answers do |t|        
	    t.references :user, index: true, foreign_key: true
	    t.references :question, index: true, foreign_key: true
	    t.text :description
	    t.timestamps null:false
		end
	end
end