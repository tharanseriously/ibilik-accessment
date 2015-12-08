get '/comments/:id/edit' do
	@comment = Comment.find(params[:id])
	erb :'comment/edit'
end

post "/comments" do
	property = Property.find(params[:property_id])
	@comment = Comment.create(content: params[:content], property_id: property.id, user_id: session[:user_id])
	redirect "/properties/#{property.id}/single"
end

patch '/comments/:id' do
	@comment = Comment.find(params[:id])
	property = Property.find(@comment.property_id)
	@comment.update(content: params[:content])
	redirect "/properties/#{property.id}/single"
end

delete '/comments/:id' do
	comment = Comment.find(params[:id])
	property = Property.find(comment.property_id)
	comment.destroy
	redirect "/properties/#{property.id}/single"
end