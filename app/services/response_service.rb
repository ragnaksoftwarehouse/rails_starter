# Used to return responses for ajax queries mainly (or if its an API)
class ResponseService < AbstractService

	def success_response(data)
		return render :json => {:errors => nil, :data => data, :status => true}, :status => 200
	end

	def dig_error(ex)
		return ex.methods.map{|x| x.to_s}.include?("errors") ? ex.errors : {:general => [ex.message]}
	end

	def error_response(ex)
		Core::ExceptionLog.create_log(ex, @session_user) if ex.class.name != "ValidationError" if @session_user
		puts_exception(ex)

		if ex.is_a?(ActiveRecord::RecordInvalid)
			errors = ex.record.errors
		elsif ex.methods.map{|x| x.to_s}.include?("errors")
			errors = data.errors
		else
			errors = {:general => [ex.message]}
		end

		return render :json => {
			:errors => errors,
			:data => nil,
			:status => false
		}, :status => ex.methods.map{|x| x.to_s}.include?("code") ? ex.code : 500 
	end

	def puts_exception(ex)
        puts ex.message.to_s
        return if Rails.env == 'production'
        puts ex.backtrace
    end
end
