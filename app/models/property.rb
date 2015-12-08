class Property < ActiveRecord::Base
	validates :address, :num_of_bedrooms, :num_of_bathrooms, presence:true
	belongs_to :user
	has_many :comments
end
