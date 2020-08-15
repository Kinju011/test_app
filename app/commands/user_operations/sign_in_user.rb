module UserOperations
	class SignInUser
		prepend SimpleCommand

		def initialize(params)
			@params = params
		end

		def call
			user = User.find_by(email: @params[:email])
			return { status: 808, success: false, message: I18n.t('users.error.invalid_password') } unless user.valid_password?(@params[:password])
			payload = { timestamp: DateTime.now, email: @params[:email]}
			secret_key = Rails.application.secrets.secret_key_base

			token = JWT.encode(payload, secret_key, 'HS256')
			DeviceDetail.create!(token: token, user_id: user&.id)
		end
	end
end