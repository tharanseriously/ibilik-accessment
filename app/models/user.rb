class User < ActiveRecord::Base
	validates :full_name, :email, :username, :password, presence: true
	validates :username, uniqueness: true
	validates :password, confirmation: true, length: {minimum: 8}
	validates :password_confirmation, presence: true
	validates :email, uniqueness: true,format: {with: /[a-zA-Z0-9_.\-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+/, message: "Email can only have lowercase or uppercase letters, numbers, underscores, dashes, or periods."}

	has_secure_password validations:false

	has_many :comments
	has_many :properties
	has_many :bookings
end
