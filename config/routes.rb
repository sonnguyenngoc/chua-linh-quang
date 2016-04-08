Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  
  get "account/login" => "account#login", as: :login
  get "account/forgotten" => "account#forgotten", as: :forgotten
  get "account/my_account" => "account#my_account", as: :my_account
  get "account/wishlist" => "account#wishlist", as: :wishlist
  get "account/register" => "account#register", as: :register
  get "account/order" => "account#order", as: :order
  get "account/address" => "account#address", as: :address
  
  get "checkout/cart" => "checkout#cart", as: :cart
  get "checkout/checkout" => "checkout#checkout", as: :checkout
  
  get "blog" => "blog#index", as: :index
  get "blog/show" => "blog#show", as: :show
  
  get "information/about_us" => "information#about_us", as: :about_us
  get "information/contact_us" => "information#contact_us", as: :contact_us
  get "information/delivery" => "information#delivery", as: :delivery
  get "information/faq" => "information#faq", as: :faq
  get "information/privacy_policy" => "information#privacy_policy", as: :privacy_policy
  get "information/terms_conditions" => "information#terms_conditions", as: :terms_conditions
  get "information/site_map" => "information#site_map", as: :site_map
  
  get "manufacturer/list" => "manufacturer#list", as: :list
  get "manufacturer/products" => "manufacturer#products", as: :products
  
  get "product/category" => "product#category", as: :category
  get "product/comparison" => "product#comparison", as: :comparison
  get "product/product" => "product#product", as: :product
  get "product/quickview" => "product#quickview", as: :quickview
  get "product/search" => "product#search", as: :search
  get "product/testimonial" => "product#testimonial", as: :testimonial
  get "product/testimonialform" => 'product#testimonialform', as: :testimonialform
  
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
