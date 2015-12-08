class CreateTables < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :full_name
			t.string :email
			t.string :username
			t.string :password_digest, :string
			t.string :bio
			t.timestamps null:false
		end
		create_table :properties do |t|
			t.string :name
			t.string :address
			t.string :description
			t.integer :num_of_bedrooms
			t.integer :num_of_bathrooms
			t.integer :price_per_month
			t.integer :sell_price
			t.integer :user_id
			t.timestamps null:false
		end
		create_table :comments do |t|
			t.string :content
			t.integer :user_id
			t.integer :property_id
			t.timestamps null:false
		end
		create_table :bookings do |t|
			t.date :start_date
			t.date :end_date
			t.string :comment
			t.integer :user_id
			t.integer :property_id
			t.integer :owner_id
			t.boolean :status
			t.timestamps null:false
		end
	end
end
