class ValidationError < StandardError
	attr_reader :errors
	attr_reader :code
	attr_reader :class_name

	def initialize(obj)
		super
		if obj.kind_of?(Hash)
			@errors = obj
			@class_name = nil
		else
			@errors = humanize_hash_errors(obj.errors.messages)
			@class_name = obj.class.name
		end
		@code = 400
		puts @errors
	end

	private
	def humanize_hash_errors(hash)
		errors = {}
		hash.each do |key, values|
			errors[key] = []
			values.each do |value|
				errors[key].push(key.to_s.humanize + ' ' + value + '. ')
			end
		end
		return errors
	end
end
