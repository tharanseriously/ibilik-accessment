class Booking < ActiveRecord::Base
	validates :start_date, :end_date, presence:true
	belongs_to :property
	belongs_to :user
end
