class AuthService < AbstractService
	def self.send_reset_email(email)
		u = User.where("email = ?", email.downcase).take
		raise GeneralError.new("User not found") if u.nil?

		u.update_attributes!(:reset_token => DateTime.now.to_s)
	end

	def self.reset_password(token, new_password)
		u = User.where("reset_token = ?", token).take
		raise GeneralError.new("Token to reset password was not found") if u.nil?

		u.update_attributes!(:password => new_password)
	end

	def self.change_password(user, curr_pass, new_pass, repeat_pass)
		raise ValidationError.new({:current => ["Provide current password"]}) if curr_pass.blank?
		raise ValidationError.new({:new => ["Provide new password"]}) if new_pass.blank?
		raise ValidationError.new({:repeated => ["Repeat new password"]}) if repeat_pass.blank?
		raise ValidationError.new({:repeated => ["Passwords do not match"]}) if new_pass != repeat_pass

		u = user.try(:authenticate, curr_pass)

		raise ValidationError.new({:current => ["Current password is invalid"]}) if u == false

		user.update_attributes!(:password => new_pass)
	end
end
