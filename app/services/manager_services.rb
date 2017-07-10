class ManagerServices
	attr_reader :system
	attr_reader :response

	def initialize(su, sc)
		@system = SystemService.new(su, sc)
		@response = ResponseService.new(su, sc)
	end
end
