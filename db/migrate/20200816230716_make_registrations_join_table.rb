class MakeRegistrationsJoinTable < ActiveRecord::Migration[5.2]
  	def up
  		Registration.delete_all
	  	remove_column :registrations, :name
	  	remove_column :registrations, :email
	  	add_column :registrations, :user_id, :integer
	end
	def down
		Registration.delete_all
	  	add_column :registrations, :name
	  	add_column :registrations, :email
	  	remove_column :registrations, :user_id
	end
end
