Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
  	resources :users do
  		collection do
  			post :sign_up
  			post :sign_in
  		end
  	end
  end
end
