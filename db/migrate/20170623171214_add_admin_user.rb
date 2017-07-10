class AddAdminUser < ActiveRecord::Migration[5.0]
  def change
  	c = Company.create!(:name => "Admin")
  	c.users.create!(
  		:firstname => "Admin", 
  		:surname => "Admin", 
  		:email => "admin@admin.com", 
  		:password => "test123!!", 
  		:password_confirmation => "test123!!",
      :user_type => "admin"
  	)
  end
end
