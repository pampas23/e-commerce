Rails.application.routes.draw do
  devise_for :users
  root :to => "home#index"

  resources :categories, :only => :show do 
  	resources :products
  end
end
