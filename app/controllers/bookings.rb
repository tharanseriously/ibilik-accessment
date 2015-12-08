get "/bookings/new"	do
	@property = Property.find(params[:id])
	erb :"booking/form"
end

get"/bookings" do
	@booking = Booking.new
	erb :"booking/my_bookings"
end

get "/bookings/edit"	do
	@booking = Booking.find(params[:id])
	erb :"booking/edit"
end

post "/bookings" do
	@property = Property.find(params[:id])
	owner = @property.user
	@booking = Booking.create(start_date: params[:start_date],end_date: params[:end_date],comment: params[:comment],property_id: @property.id, user_id: session[:user_id], owner_id: owner.id)

	erb :"booking/my_bookings"
end

patch '/bookings/:id' do
	@booking =Booking.find(params[:id])
	@booking.update(start_date: params[:start_date],end_date: params[:end_date],comment: params[:comment])
	@property = Property.find(@booking.property_id)
	erb :"booking/my_bookings"
end

delete '/bookings/:id' do
	booking = Booking.find(params[:id])
	booking.destroy
	redirect "/bookings"
end


