Rails.application.routes.draw do
  devise_for :users
  
  resources :users, except: [ :destroy, :index ]
  resources :surfboards
  resources :bookings, only: [ :new, :create, :index, :show ]


  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
