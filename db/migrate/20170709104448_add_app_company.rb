class AddAppCompany < ActiveRecord::Migration[5.0]
  def change
  	c = Company.create!(:name => "App")
  end
end
