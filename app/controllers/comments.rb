get '/comments/:id/edit' do
	@comment = Comment.find(params[:id])
	erb :'property/edit'
end

post "/comments" do
	property = Property.find(params[:property_id])
	@comment = Comment.create(content: params[:content], property_id: property.id, user_id: session[:user_id])
	redirect "/properties/#{property.id}/single"
end

patch '/comments/:id' do
	@comment = Property.find(params[:id])
	@comment.update(address: params[:address], description: params[:description], num_of_bedrooms: params[:num_of_bedrooms], num_of_bathrooms: params[:num_of_bathrooms], price_per_month: params[:price_per_month], sell_price: params[:sell_price],user_id: session[:user_id], name: params[:name])
	redirect "/properties/#{@property.id}/single"
end

delete '/comments/:id' do
	comment = Comment.find(params[:id])
	property = Property.find(comment.property_id)
	comment.destroy
	redirect "/properties/#{property.id}/single"
end