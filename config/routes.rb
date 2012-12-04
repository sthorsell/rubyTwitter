Twitter::Application.routes.draw do
  get "home/index"
  post "home/display"
  # get "home/display"
  
  
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", :registrations => 'registrations'}
  
  resources :home
    root :to => 'home#index'

end
