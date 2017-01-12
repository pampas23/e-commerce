Rails.application.routes.draw do
  devise_for :users
  root :to => "home#index"

  resources :categories, :only => :show do 
  	resources :products , :only => [:show, :destroy] do
  		post 'add', on: :member
  	end
  end

  resource :cart, :only => [:show, :destroy]
  resources :orders, only: [:index, :new, :create, :show]
end