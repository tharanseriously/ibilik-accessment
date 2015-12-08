get "/properties" do
	@user = User.find(session[:user_id])
	@property = Property.new
	erb :"property/my_properties"
end

get "/properties/:id/single" do
	@property = Property.find(params[:id])
	erb :"property/single"
end

get '/properties/:id/edit' do
	@property = Property.find(params[:id])
	erb :'property/edit'
end

post "/properties" do
	@user = User.find(session[:user_id])
	@property = Property.create(address: params[:address], description: params[:description], num_of_bedrooms: params[:num_of_bedrooms], num_of_bathrooms: params[:num_of_bathrooms], price_per_month: params[:price_per_month], sell_price: params[:sell_price],user_id: session[:user_id], name: params[:name])
	
	erb :"property/my_properties"
end

patch '/properties/:id' do
	@property = Property.find(params[:id])
	@property.update(address: params[:address], description: params[:description], num_of_bedrooms: params[:num_of_bedrooms], num_of_bathrooms: params[:num_of_bathrooms], price_per_month: params[:price_per_month], sell_price: params[:sell_price],user_id: session[:user_id], name: params[:name])
	redirect "/properties/#{@property.id}/single"
end

delete '/properties/:id' do
	property = Property.find(params[:id])
	property.destroy
	property.comments.destroy_all
	redirect "/users/#{session[:user_id]}"
end