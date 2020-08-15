module Api
	class ArticlesController < ApplicationController
		def index
			articles = Article.select(:id, :title, :description).all
			render json: {status: 200, success: true, message: 'Result', data: articles}
		end
	end
end