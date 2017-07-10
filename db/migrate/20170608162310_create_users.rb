class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :firstname
    	t.string :surname
    	t.string :email
    	t.string :password
    	t.string :password_digest
    	t.integer :company_id
      	t.timestamps
    end
  	add_foreign_key :users, :companies
  end
end
