Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  post 'groups/join' => 'groups#join', as: :join
  get 'homes/about' => 'homes/about', as: :about
  resources :plans, only:[:edit, :update, :create, :show, :destroy, :new]
  resources :users
  resources :groups
  resources :grplans, only:[:edit, :update, :create, :show, :destroy]
  resources :notifications
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
