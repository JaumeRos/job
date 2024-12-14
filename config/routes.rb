Rails.application.routes.draw do
  devise_for :users
  
  resources :jobs do
    member do
      post :publish
      post :unpublish
    end
  end
  
  resources :charges, only: [:create] do
    collection do
      get :success
    end
  end
  
  get 'dashboard', to: 'pages#dashboard'
  get 'pricing', to: 'pages#pricing'
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'terms-of-service', to: 'pages#terms'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'careers', to: 'pages#careers'
  
  root 'jobs#index'
end
