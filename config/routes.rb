Cheers::Application.routes.draw do
  resources :invitations

  resources :users

  resources :events

  match 'authentication' => 'authentication#index'
  match 'authentication/login' => 'authentication#login'
  match 'authentication/logout' => 'authentication#logout'

  match 'events/:event_id/invitations/new' => 'invitations#new'
  match 'events/:event_id/invitations/:id/edit' => 'invitations#edit'

  post 'events/:event_id/invitation' => 'invitations#create'
  put 'events/:event_id/invitation/:id' => 'invitations#update'
  delete 'events/:event_id/invitation/:id' => 'invitations#destroy'

  root :to=>'events#index'

end
