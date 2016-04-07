Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  
  namespace :admin do
    get "main" => "main#index"
    resources :products
    resources :categories
    resources :manufacturers
    resources :articles
    resources :article_categories
    resources :areas
  end
end
