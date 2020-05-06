Rails.application.routes.draw do
  root 'home#top'
  get 'characters', to: 'characters#index'
  get 'characters/new', to: 'characters#new'
  post 'characters', to: 'characters#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
