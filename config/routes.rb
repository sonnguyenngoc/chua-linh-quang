Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  
  get "account/login" => "account#login", as: :login
  get "account/logout" => "account#logout", as: :logout
  get "account/forgotten" => "account#forgotten", as: :forgotten
  get "account/my_account" => "account#my_account", as: :my_account
  get "account/wishlist" => "account#wishlist", as: :wishlist
  get "account/register" => "account#register", as: :register
  get "account/order" => "account#order", as: :order
  get "account/order/info" => "account#order_info", as: :order_info
  get "account/address" => "account#address", as: :address
  get "account/address/edit" => "account#address_edit", as: :address_edit
  get "account/download" => "account#download", as: :download
  get "account/recurring" => "account#recurring_payments", as: :recurring_payments
  get "account/reward_points" => "account#reward_points", as: :reward_points
  get "account/return" => "account#return_list", as: :return_list
  get "account/return/add" => "account#return_product", as: :return_product
  get "account/transaction" => "account#transaction", as: :transaction
  get "account/newsletter" => "account#newsletter", as: :newsletter
  get "account/edit" => "account#edit", as: :edit
  get "account/password" => "account#password", as: :password
  get "account/voucher" => "account#voucher", as: :voucher
  
  get "checkout/cart" => "checkout#cart", as: :cart
  get "checkout/checkout" => "checkout#checkout", as: :checkout
  get "opencart/checkout/success" => "checkout#success", as: :success
  
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
  get "product/quick_view" => "product#quick_view", as: :quick_view
  get "product/search" => "product#search", as: :search
  get "product/testimonial" => "product#testimonial", as: :testimonial
  get "product/testimonialform" => "product#testimonialform", as: :testimonialform
  get "product/special" => "product#special", as: :special
  
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
