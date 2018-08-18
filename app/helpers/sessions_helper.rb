module SessionsHelper
	# Sessions Creation
	# PRE: User must exist in database
	# POST: Sets up sessions parameter corresponding to user ID (securely hashed)
	# PARAMS: user = user found in database
	def log_in(user)
	  	session[:user_id] = user.id
	end

	# User Finder
	# PRE: -
	# POST: Finds user if session or cookies exist
	# PARAMS: -
	def current_user
		if (user_id = session[:user_id])
		  @current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
		  user = User.find_by(id: user_id)
		  if user && user.authenticated?(:remember, cookies[:remember_token])
		    log_in user
		    @current_user = user
		  end
		end
	end

	# Sessions and Cookies Login
	# PRE: -
	# POST: Returns true if user is found by associated session or cookies
	# PARAMS: -
  	def logged_in?          
    	!current_user.nil?    
	end

	# Remembers a user in a persistent session.
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# Destroy 
	# PRE: User must exist in database
	# POST: Deletes sessions parameter associated to user
	# PARAMS: -
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
end
