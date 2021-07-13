Rails.application.routes.draw do
  get 'hashtags/show'
  root 'users#index'
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]
  resources :hashtags, only: [:show], param: :name
end
