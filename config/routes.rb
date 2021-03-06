Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  resources :users, only: [ :edit, :update, :show ]
  resources :surfboards
  resources :bookings, only: [ :new, :create, :show, :update ]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
