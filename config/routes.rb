Rails.application.routes.draw do

	match '/' => 'web#index', :as => 'default', :via => [:get, :post]
	match '/auth/signin' => 'auth#signin', :as => 'auth_signin', :via => [:get, :post]
	match '/auth/signup' => 'auth#signup', :as => 'auth_signup', :via => [:get, :post]
	match '/auth/reset-password' => 'auth#reset_password', :as => 'auth_reset_password', :via => [:get, :post]
	match '/auth/change-password/:token' => 'auth#change_password', :as => 'auth_change_password', :via => [:get, :post]
	match '/auth/signout' => 'auth#signout', :as => 'auth_signout', :via => [:get]

	namespace :admin do
		match '/companies' => 'companies#index', :as => "companies", :via => [:get]
		match '/companies/create' => 'companies#create', :as => "companies_create", :via => [:get, :post]
		match '/companies/:id/details' => 'companies#details', :as => "companies_details", :via => [:get, :post]
	end

	######### COMPANY ##########
		match '/:companyslug/dashboard' => 'dashboard#index', :as => 'dashboard', :via => [:get]
		# Profile
		match '/:companyslug/profile' => 'profile#index', :as => 'profile_index', :via => [:get, :post]
end
