class SessionsController < ApplicationController

	def new
	end

	def create

		user = User.authenticate(params[:session][:mail],params[:session][:password])

		if user
			sign_in user
			redirect_to user
		else
			flash.now['alert alert-danger'] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

end