Rails.application.routes.draw do
  devise_for :users
  root :to => "home#index"

  resources :categories, :only => :show do 
  	resources :products , :only => [:show, :destroy] do
  		post 'add', on: :member
  	end
  end
  
  post 'pay2go/return' => 'pay2go#return'
  post 'pay2go/notify' => 'pay2go#notify'

  resource :cart, :only => [:show, :destroy]
  resources :orders, only: [:index, :new, :create, :show] do
    post :checkout, on: :member
  end
end