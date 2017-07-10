class AbstractService
	attr_reader :session_user
	attr_reader :session_company

	def initialize(su, sc)
		@session_user = su
		@session_company = sc
	end
end
