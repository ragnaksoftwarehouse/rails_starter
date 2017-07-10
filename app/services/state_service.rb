class StateService
	# States for StateMachine for controller
	ST_ERR = 'error'
	ST_SUC = 'success'
	ST_IDL = 'idle'

	@state = ST_IDL
	@errors = nil
	@info = {}

	attr_accessor :info
	attr_accessor :state
	attr_accessor :errors

	# if new_state is error, then data should be an exception
	# thrown by validation or any other part of code
	def move(new_state, data)
		self.state = new_state
		puts self.state
		if self.state == ST_ERR
			if data.is_a?(ActiveRecord::RecordInvalid)
				self.errors = data.record.errors
			elsif data.methods.map{|x| x.to_s}.include?("errors")
				self.errors = data.errors
			elsif data.include?("message")
				self.errors = {:general => [data.message]}
			elsif data.is_a?(String)
				self.errors = {:general => data}
			end
		end
	end

	def is_errored?
		return self.errors != nil
	end

	def succeeded?
		return self.state == ST_SUC
	end

	def error_msg(def_msg = '')
		return "" if self.errors.nil?
		return self.errors if self.errors.is_a?(String)
		return self.errors[:general] if self.errors.include?(:general)
		return self.errors.full_messages  if self.errors.include?(:full_messages)
		return def_msg
	end
end
