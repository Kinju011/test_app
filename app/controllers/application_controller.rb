class ApplicationController < ActionController::API

	def send_response(status, success, message, data=nil)
		render json: {status: status, success: success, message: message, data: data}
	end

	def check_required_params(required_params_list)
	    missing_params_list = []
	    required_params_list.each do |field|
	      missing_params_list << field unless params[field].present?
	    end
	    missing_params_list.empty?
  	end
end
