module UserOperations
	class AddNewUserCommand
		prepend SimpleCommand

		def initialize(params)
			@params = params			
		end

		def call
			ActiveRecord::Base.transaction do
				User.create!(@params)
			end
			{ status: 200, success: true, message: I18n.t('users.success.created') }
		rescue => e
			errors.add(:base, { status: 500, success: false, message: e.message })
		end
	end
end