Rails.application.routes.draw do
  devise_for :users
  
  # Job listings and applications
  resources :jobs do
    member do
      post :publish
      post :unpublish
    end
    resources :applications, only: [:create]
  end
  
  # Teaching Categories
  get 'teaching-categories', to: 'teaching_categories#index', as: :teaching_categories
  get 'teaching-categories/:category', to: 'teaching_categories#show', as: :teaching_category
  
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
  
  root 'pages#home'
end
