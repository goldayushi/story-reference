Rails.application.routes.draw do
  get 'glossaries/index'
  get 'glossaries/new'
  get 'glossaries/create'
  get 'glossaries/show'
  get 'glossaries/edit'
  get 'glossaries/update'
  get 'glossaries/destroy'
  root 'home#top'
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
