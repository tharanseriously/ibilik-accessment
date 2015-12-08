get '/' do
	if params[:id]
		@user = User.find(params[:id])
	else
		@user = User.new
	end
 	erb :"static/index"
end