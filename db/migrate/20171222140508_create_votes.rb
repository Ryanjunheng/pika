class CreateVotes < ActiveRecord::Migration[5.0]
	def change
		create_table :votes do |t|
		t.references :answer, index: true, foreign_key: true     
	    t.references :user, index: true, foreign_key: true
	    t.integer :count, default: 0
	    t.timestamps null: false
	end
	end
end
