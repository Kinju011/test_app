class Api::DeckDealersController < ApplicationController

	def create
		command = DeckOperations::DeckDealing.call(params)
		if command.success?
			response = command.result
			send_response(response[:status], response[:success], response[:message], response[:data])
		else
			response = command.errors[:base].first
			send_response(response[:status], response[:success], response[:message])
		end
	end

end
