Rails.application.routes.draw do
  devise_for :users
  root "movies#index"

  resources :movies do
		resources :reviews, only: [:new, :show, :create]
	end
  resources :moviegoers, only: [:index, :new, :show, :create]

  get "/operations/top20", to: "operations#top20"
  get "/operations/bootstrap", to: "operations#bootstrap"
  
end
