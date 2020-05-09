Rails.application.routes.draw do
  get 'episodes/index'
  get 'episodes/new'
  get 'episodes/create'
  get 'episodes/show'
  get 'episodes/edit'
  get 'episodes/update'
  get 'episodes/destroy'
  root 'home#top'
  get 'characters', to: 'characters#index'
  get 'characters/search', to: 'characters#search'
  get 'characters/new', to: 'characters#new'
  post 'characters', to: 'characters#create'
  get 'characters/:id', to: 'characters#show'
  get 'characters/:id/edit', to: 'characters#edit'
  patch 'characters/:id', to: 'characters#update'
  delete 'characters/:id/delete', to: 'characters#destroy'
end
