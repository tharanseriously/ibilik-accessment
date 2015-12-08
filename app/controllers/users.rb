get "/users/new/" do
	if params[:error]
		@error = params[:error]
	end
	@user = User.new
	erb :"user/form"
end

get "/users/logout" do
	session[:user_id] = nil
	redirect "/"
end

get "/users/:id" do
	@user = User.find(params[:id])
	erb :"user/show"
end

get "/users/:id/edit" do
	@user = User.find(session[:user_id])
	erb :"user/edit"
end

get "/users/:id/passwordchange/" do
	if params[:error]
		@error = params[:error]
	end
	@user = User.find(session[:user_id])
	erb :"user/change_password"
end

post "/users" do
	@user = User.new(full_name: params[:full_name], email: params[:email], username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
	if @user.save	
		session[:user_id] = @user.id
		redirect "/?id=#{@user.id}"
	else
		erb :"user/form"
	end
end

post "/users/login" do
	@user = User.find_by(username: params[:username])
	if @user.nil?
		@error = "Username not found"
		redirect "/users/new/?error=#{@error}"
	elsif @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect "/?id=#{@user.id}"
	else
		@error = "Wrong password"
		redirect "/users/new/?error=#{@error}"
	end
end

post "users/:id/delete" do
	user = User.find(params[:id])
	if user.properties.any?
		user.properties.destroy_all
	end
	if user.bookings.any?
		user.bookings.destroy_all
	end
	if user.comments.any?
		user.comments.each do |comment|
			comment.user_id = 1
		end
	end
	user.destroy
	session[:user_id] = nil
	redirect "/"
end

patch '/users/:id' do
	@user = User.find(params[:id])
	@user.update(full_name: params[:full_name], email: params[:email], username: params[:username], bio: params[:bio], password: params[:password], password_confirmation: params[:password_confirmation])
	if @user.save
		redirect "/users/#{@user.id}"
	else
		erb :'user/edit'
	end
end

patch '/users/:id/passwordchange' do
	@user = User.find(params[:id])
	
	if @user.authenticate(params[:password])
		@user.update(password: params[:newpassword], password_confirmation: params[:newpassword_confirmation])
		if @user.errors.any?
			erb :"user/change_password"
		else
			redirect "/users/#{@user.id}"
		end
	elsif @user.authenticate(params[:password]) == false
		@error = "Wrong current password"
		redirect "/users/#{session[:user_id]}/passwordchange/?error=#{@error}"
	end	
end