class ApplicationController < ActionController::Base

private

	def require_signin
		unless current_user
			session[:intended_url] = request.url
			redirect_to new_session_path, alert: "You need to be logged in to access this page."
		end
	end

	def current_user
		User.find_by_id(session[:user_id]) if session[:user_id]
	end

	helper_method :current_user

	def current_user?(user)
		current_user == user
	end

	helper_method :current_user?

	def current_user_admin?
		current_user && current_user.admin?
	end

	helper_method :current_user_admin?

 	def require_admin
 		unless current_user_admin?
 			redirect_to root_url, alert: "You must be an admin to access this section."
 		end
 	end

end
