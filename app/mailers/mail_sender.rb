class MailSender < ApplicationMailer

	def default_email(email, subject, params)
		@params = params
		mail(to: email, subject: subject)
	end

end
