class ProfileController < ApplicationController
	def index
		@user = User.find(@user_session.id)
		@state.info[:kind] = ''

		if request.method == "POST"
			begin
				@state.info[:kind] = params[:kind]

				if @state.info[:kind] == "info"
					User.where(:id => @user_session[:id]).take.update_attributes!(User.allowed_fields(params))
					flash[:notice] = I18n.t('messages.profile_updated')
				elsif @state.info[:kind] == "password"
					AuthService.change_password(
						@user, 
						params[:password][:current],
						params[:password][:new],
						params[:password][:repeated]
					)
					flash[:notice] = I18n.t('messages.password_changed')
				end
				redirect_to profile_index_path
			rescue => ex
				@state.move(StateService::ST_ERR, ex)
			end
		end
	end
end