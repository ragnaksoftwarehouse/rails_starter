class AuthController < ApplicationController
	def signin
		if request.method == 'POST'
			u = User.find_by(email: params[:email]).try(:authenticate, params[:password])
			if u.nil?
				@state.move(StateService::ST_ERR, I18n.t('errors.credentails'))
			else
				session[:user] = u
				if u
					return redirect_to dashboard_path(:companyslug => u.company.slug) unless u.is_admin?
					return redirect_to admin_companies_path if u.is_admin?
				end
			end
		end
		render layout: 'guest'
	end

	def signup
		if request.method == 'POST'
			begin
				u = @app_company.users.create!(User.allowed_fields(params))
				session[:user] = u
				return redirect_to dashboard_path(:companyslug => u.company.slug) unless u.is_admin?
				return redirect_to admin_companies_path if u.is_admin
			rescue => ex
				@state.move(StateService::ST_ERR, ex)
			end
		end
		render layout: 'guest'
	end

	def reset_password
		@error = ''
		if request.method == 'POST'
			begin
				AuthService.send_reset_email(params[:email])
				@state.move(StateService::ST_SUC, nil)
			rescue => ex
				@state.move(StateService::ST_ERR, ex)
			end
		end
		render layout: 'guest'
	end

	def change_password
		@error = ''
		if request.method == 'POST'
			begin
				AuthService.reset_password(params[:token], params[:password])
				@state.move(StateService::ST_SUC, nil)
			rescue => ex
				@state.move(StateService::ST_ERR, ex)
			end
		end
		render layout: 'guest'
	end

	def signout
		session.delete(:user)
		return redirect_to auth_signin_path
	end
end
