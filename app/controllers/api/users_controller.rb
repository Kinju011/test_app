class Api::UsersController < ApplicationController
	before_action :authenticated_request!, only: [:index]
	def index
		command = UserOperations::GetUserListCommand.call('name')
		if command.success?
			response = command.result
		else
			response = command.errors[:base].first
		end		
		send_response(response[:status], response[:success], response[:message], response[:data])
	end

	def sign_up
		required_params = check_required_params([:user])
		return send_response(403, false, I18n.t('param_missing')) unless required_params
		command = UserOperations::AddNewUserCommand.call(user_params)
		if command.success?
			response = command.result
		else
			response = command.errors[:base].first
		end
		send_response(response[:status], response[:success], response[:message])
	end

	def sign_in
		required_params = check_required_params([:password, :email])
		return send_response(403, false, I18n.t('param_missing')) unless required_params

		command = UserOperations::SignInUser.call(params)
		if command.success?
			response = command.result
		else
			response = command.errors[:base].first
		end
		send_response(response[:status], response[:success], response[:message], response[:data])
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :phone)
	end
end
