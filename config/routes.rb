Cheers::Application.routes.draw do
  resources :users

  resources :events do
    resources :invitations, :except => [:index, :show]
    resources :comments, :only => [:create, :edit, :update, :destroy]
  end

  match 'authentication' => 'authentication#index'
  match 'authentication/login' => 'authentication#login'
  match 'authentication/logout' => 'authentication#logout'

  root :to=>'events#index'
end
