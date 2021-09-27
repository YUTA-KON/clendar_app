Rails.application.routes.draw do
  get 'homes/top'
  root to: 'homes#top'
  resources :plans
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
