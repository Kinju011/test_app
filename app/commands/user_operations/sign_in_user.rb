module UserOperations
	class SignInUser
		prepend SimpleCommand

		def initialize(params)
			@params = params
		end

		def call
			user = User.find_by(email: @params[:email])
			return { status: 404, success: false, message: 'User not found' } unless user.present?
			return { status: 808, success: false, message: 'Invalid Password' } unless user.valid_password?(@params[:password])
			payload = { timestamp: DateTime.now, email: @params[:email]}
			secret_key = Rails.application.secrets.secret_key_base

			token = JWT.encode(payload, secret_key, 'HS256')
			DeviceDetail.create!(token: token, user_id: user&.id)
			data = { name: user&.first_name+' '+user&.last_name, email: user&.email, phone: user&.phone, token: token }
			return {status: 200, success: true, message: 'success', data: data }
		end
	end
end