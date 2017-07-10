class User < ApplicationRecord
	has_secure_password

	validates_presence_of :firstname, :surname, :email, :company_id
	belongs_to :company

	def name
		return self.firstname + " " + self.surname
	end

	def is_admin?
		return self.user_type == "admin"
	end

	def self.allowed_fields(params)
		return params.require(:user).permit(:firstname, :surname, :email, :password, :lang)
	end
end
