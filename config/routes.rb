Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/about' => 'homes/about', as: :about
  resources :plans
  resources :users
  resources :groups
  get 'groups/:id/join' => 'groups#join', as: :join
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
