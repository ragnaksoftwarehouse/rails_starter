class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
    before_action :add_allow_credentials_headers
    before_action :authenticate_user, :except => [
        :company_sign_up
    ]

    # type: ManagerServices, keeps all services avaialble for controllers and views,
    # all services have injected current user and company session
    attr_reader :services

    def default
        return redirect_to auth_signin_path if @user_session.nil?
        return redirect_to dashboard_path(:companyslug => u.company.slug) if @user_session.role != "admin"
        return redirect_to admin_dashboard_path if @user_session.role == "admin"
    end

	def add_allow_credentials_headers
	    response.headers['Access-Control-Allow-Origin'] = '*'
	    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
	    response.headers['Access-Control-Request-Method'] = '*'
	    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-Access-Token'

	    return render :json => 'OK' if request.method == 'OPTIONS'

        @state = StateService.new
        @state.info = {}
        @app_company = Company.find_by(:name => "App")
	end

    # Abstract method, to override by admin controllers
    def check_if_should_be_admin
    end

    def authenticate_user
        @session = nil
        @user_session = nil
        @company_session = nil

        # This is protected area available for logged in users only from this company
        unless params[:companyslug].blank?
            @company_session = Company.where(:slug => params[:companyslug]).take
            return redirect_to auth_signin_path if session[:user].blank? || @company_session.nil?

            @user_session = @company_session.users.where("users.id = ?", session[:user]["id"]).first
            return redirect_to auth_signin_path if @user_session.nil?

            @session = {:company => @company_session, :user => @user_session}
        end

        @services = ManagerServices.new(@user_session, @company_session)

        @services.system.set_lang(params, @user_session)

        self.check_if_should_be_admin
    end
end


