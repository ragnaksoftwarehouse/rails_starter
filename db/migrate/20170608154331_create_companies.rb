class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
    	t.string :name
    	t.string :slug
      	t.timestamps
    end
    
    add_index :companies, :name, :unique => true
  end
end
