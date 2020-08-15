module UserOperations
	class GetUserListCommand
		prepend SimpleCommand

		def initialize(param)
			@param = param
		end

		def call
			users = User.all
			return { status: 200, success: true, message: 'Result', data: users }
		rescue => e
			errors.add(:base, { status: 500, success: false, message: e.message })
		end
	end
end