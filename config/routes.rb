Cheers::Application.routes.draw do
  resources :users

  resources :events

  match 'authentication' => 'authentication#index'
  match 'authentication/login' => 'authentication#login'
  match 'authentication/logout' => 'authentication#logout'

  root :to=>'events#index'

end
