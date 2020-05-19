# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#top'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :characters
  resources :episodes
  resources :chronologies
  resources :glossaries
  resources :users
  get '*path', to: 'application#routing_error'
  post '*path', to: 'application#routing_error'
end
