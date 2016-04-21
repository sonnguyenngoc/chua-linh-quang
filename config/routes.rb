Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    root "home#countdown"
    get "home" => "home#index", as: :home
    
    # account
    get "account/login" => "account#login", as: :login
    get "account/quick_login" => "account#quick_login", as: :quick_login
    get "account/logout" => "account#logout", as: :logout
    get "account/forgotten" => "account#forgotten", as: :forgotten
    get "account/my_account" => "account#my_account", as: :my_account
    get "account/wishlist" => "account#wishlist", as: :wishlist
    get "account/register" => "account#register", as: :register
    get "account/order" => "account#order", as: :account_order
    get "account/order/info/:order_id" => "account#order_info", as: :order_info
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
    get "account/voucher/success" => "account#voucher_success", as: :voucher_success
    # end account
    
    # checkout
    get "checkout/shopping_cart" => "checkout#shopping_cart", as: :shopping_cart
    get "checkout/checkout" => "checkout#checkout", as: :checkout
    get "checkout/success" => "checkout#success", as: :success
    # end checkout
    
    # blog
    get "blog" => "blog#index", as: :index
    get "blog/show/:blog_id" => "blog#show", as: :show
    get "blog/article_category/:article_category_id" => "blog#article_category", as: :article_category
    # end blog
    
    # information
    get "information/about_us" => "information#about_us", as: :about_us
    get "information/contact_us" => "information#contact_us", as: :contact_us
    get "information/finish_contact_us" => "information#finish_contact_us", as: :finish_contact_us
    get "information/finish_newsletter" => "information#finish_newsletter", as: :finish_newsletter
    get "information/delivery" => "information#delivery", as: :delivery
    get "information/faq" => "information#faq", as: :faq
    get "information/privacy_policy" => "information#privacy_policy", as: :privacy_policy
    get "information/terms_conditions" => "information#terms_conditions", as: :terms_conditions
    get "information/sitemap" => "information#sitemap", as: :sitemap
    # end information
    
    # manufacturer
    get "manufacturer/list" => "manufacturer#list", as: :list
    get "manufacturer/products/:manufacturer_id" => "manufacturer#products", as: :products
    # end manufacturer
    
    # product
    get "product/category/:category_id" => "product#category", as: :category
    get "product/comparison" => "product#comparison", as: :comparison
    get "product/product/:product_id" => "product#product", as: :product
    get "product/quick_view/:product_id" => "product#quick_view", as: :quick_view
    get "product/search" => "product#search", as: :search
    get "product/testimonial" => "product#testimonial", as: :testimonial
    get "product/testimonialform" => "product#testimonialform", as: :testimonialform
    get "product/special" => "product#special", as: :special
    # end product
    
    # resources
    resources :comments
    resources :newsletters
    resources :contacts
    devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }
    resources :carts
    resources :line_items
    resources :customers
    resources :orders
    resources :wish_lists
    resources :line_item_compares
    resources :compares
    resources :questions
    resources :comment_articles
    #end of resources
  
    namespace :admin, path: "hkpanel" do
      get "/" => "main#index"
      resources :shopping_carts
      resources :products do
        collection do
          get 'search'
        end
      end
      resources :categories do
        collection do
          get 'search'
          get 'update_parent_order'
        end
      end
      resources :manufacturers do
        collection do
          get 'search'
        end
      end
      resources :articles do
        collection do
          get 'search'
        end
      end
      resources :article_categories do
        collection do
          get 'search'
        end
      end
      resources :areas do
        collection do
          get 'search'
        end
      end
      resources :orders do
        collection do
          get 'search'
        end
      end
      resources :newsletters
      resources :contacts
      resources :wish_lists
      resources :payment_methods
      resources :delivery_methods
    end
  end
end
