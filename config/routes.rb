Rails.application.routes.draw do
  root 'home#top'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'users/index', to: 'users#index'
  get 'users/:id/edit', to: 'users#edit'
  resources :characters
  resources :episodes
  #get 'episodes', to: 'episodes#index'
  #get 'episodes/new', to: 'episodes#new'
  #post 'episodes', to: 'episodes#create'
  #get 'episodes/:id', to: 'episodes#show'
  #get 'episodes/:id/edit', to: 'episodes#edit'
  #patch 'episodes/:id', to: 'episodes#update'
  #delete 'episodes/:id', to: 'episodes#destroy'
  resources :chronologies
  resources :glossaries
end
