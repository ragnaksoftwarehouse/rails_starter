class Admin::AdminController < ApplicationController
	layout 'admin'

	def check_if_should_be_admin
		@user_session = User.where("users.id = ?", session[:user]["id"]).eager_load(:company).first

		if @user_session.role != "admin"
			session.delete(:user)
			return redirect_to auth_signin_path
		end

		@session = {:company => @user_session.company, :user => @user_session}
	end
end