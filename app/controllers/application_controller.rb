class ApplicationController < ActionController::API

	def send_response(status, success, message, data=nil)
		render json: {status: status, success: success, message: message, data: data}
	end

	def authenticated_request!
	    if request.headers['HTTP_AUTH_TOKEN'].present?
	      device_detail = DeviceDetail.find_by(token: request.headers['HTTP_AUTH_TOKEN'])
	      if !device_detail.present?	        
	        render json: { errors: 'Invalid token' }, status: :ok
	      end
	    else
	      render json: { errors: 'Token is missing' }, status: :ok
	    end
  	end

	def check_required_params(required_params_list)
	    missing_params_list = []
	    required_params_list.each do |field|
	      missing_params_list << field unless params[field].present?
	    end
	    missing_params_list.empty?
  	end
end
