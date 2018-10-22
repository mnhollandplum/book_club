Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books do
    resources :authors, only: [:destroy]
    resources :reviews, only: [:destroy]
    end
  resources :users
  resources :authors
  resources :reviews

end
