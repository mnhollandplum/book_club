Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, except:[:edit, :update]
  resources :user, only:[:show]
  resources :authors, only:[:show]

end
