class GeneralError < StandardError
	attr_reader :errors
	attr_reader :code

	def initialize(errors)
		super
		@errors = errors
		@code = 406
	end
end