class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:notice] = "Welcome back, #{user.name}!"
			redirect_to(session[:intended_url] || user)
			session[:intended_url] = nil
		else
			flash.now[:alert] = "Incorrect email / password"
			render :new
		end
	end

	def destroy
		user = User.find_by(email: params[:email])
		session[:user_id] = nil;
		flash[:notice] = "Successfully Signed Out!"
		redirect_to root_path
	end

end
