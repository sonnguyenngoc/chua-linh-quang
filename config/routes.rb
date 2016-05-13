Rails.application.routes.draw do
  
  scope "(:locale)", locale: /vi|en/, defaults: {locale: "vi"} do
    root "home#countdown"
    get "san-pham" => "home#index", as: :home
    
    # change current area session
    get "change_current_area/:area_id" => "home#change_current_area", as: :change_current_area
    
    # account
    get "tai-khoan/dang-nhap" => "account#login", as: :login
    get "tai-khoan/dang-nhap-nhanh" => "account#quick_login", as: :quick_login
    get "tai-khoan/dang-xuat" => "account#logout", as: :logout
    get "tai-khoan/quen-mat-khau" => "account#forgotten", as: :forgotten
    resources :password_resets
    get "tai-khoan/tai-khoan-cua-toi" => "account#my_account", as: :my_account
    get "tai-khoan/san-pham-yeu-thich" => "account#wishlist", as: :wishlist
    get "tai-khoan/dang-ky" => "account#register", as: :register
    get "tai-khoan/lich-su-dat-hang" => "account#order", as: :account_order
    get "tai-khoan/lich-su-dat-hang/trang-chi-tiet/:order_id" => "account#order_info", as: :order_info
    get "tai-khoan/dia-chi-cho-don-hang" => "account#address", as: :address
    get "tai-khoan/dia-chi-cho-don-hang/chinh-sua" => "account#address_edit", as: :address_edit
    get "tai-khoan/download" => "account#download", as: :download
    get "tai-khoan/recurring" => "account#recurring_payments", as: :recurring_payments
    get "tai-khoan/reward_points" => "account#reward_points", as: :reward_points
    get "tai-khoan/return" => "account#return_list", as: :return_list
    get "tai-khoan/return/add" => "account#return_product", as: :return_product
    get "tai-khoan/transaction" => "account#transaction", as: :transaction
    get "tai-khoan/dang-ky-nhan-tin-moi" => "account#newsletter", as: :newsletter
    get "tai-khoan/chinh-sua-thong-tin" => "account#edit", as: :edit
    get "tai-khoan/mat-khau" => "account#password", as: :password
    get "tai-khoan/phieu-mua-hang" => "account#voucher", as: :voucher
    get "tai-khoan/phieu-mua-hang/phieu-mua-hang-da-dung" => "account#voucher_success", as: :voucher_success
    get "tai-khoan/chua-dang-nhap" => "account/no_singed", as: :no_singed
    # end account
    
    # checkout
    get "dat-hang/gio-hang" => "checkout#shopping_cart", as: :shopping_cart
    get "dat-hang/dat-hang" => "checkout#checkout", as: :checkout
    get "dat-hang/dat-hang-thanh-cong" => "checkout#success", as: :success
    # end checkout
    
    # blog
    get "bai-viet" => "blog#index", as: :index
    get "bai-viet/chi-tiet-bai-viet/:blog_id" => "blog#show", as: :show
    get "bai-viet/chuyen-muc-bai-viet/:article_category_id" => "blog#article_category", as: :article_category
    # end blog
    
    # information
    get "thong-tin/ve-chung-toi" => "information#about_us", as: :about_us
    get "thong-tin/lien-he" => "information#contact_us", as: :contact_us
    get "thong-tin/gui-lien-he-thanh-cong" => "information#finish_contact_us", as: :finish_contact_us
    get "thong-tin/dang-ky-thanh-cong" => "information#finish_newsletter", as: :finish_newsletter
    get "thong-tin/thong-tin-giao-hang" => "information#delivery", as: :delivery
    get "thong-tin/cau-hoi-thuong-gap" => "information#faq", as: :faq
    get "thong-tin/chinh-sach-bao-mat" => "information#privacy_policy", as: :privacy_policy
    get "thong-tin/dieu-khoan-dieu-kien" => "information#terms_conditions", as: :terms_conditions
    get "thong-tin/so-do-website" => "information#sitemap", as: :sitemap
    # end information
    
    # manufacturer
    get "thuong-hieu-cung-cap/danh-sach" => "manufacturer#list", as: :list
    get "thuong-hieu-cung-cap/danh-sach-san-pham/:manufacturer_id" => "manufacturer#products", as: :products
    # end manufacturer
    
    # branch
    get "chi-nhanh/danh-sach" => "branch#list", as: :list_branch
    # end branch
    
    # product
    get "san-pham/chuyen-muc/:category_id" => "product#category", as: :category
    get "san-pham/tat-ca-chuyen-muc" => "product#all_category", as: :all_category
    get "san-pham/san-pham-so-sanh" => "product#comparison", as: :comparison
    get "san-pham/chi-tiet-san-pham/:product_id" => "product#product", as: :product
    get "san-pham/xem-nhanh/:product_id" => "product#quick_view", as: :quick_view
    get "product/add_cart_success" => "product/add_cart_success", as: :add_cart_success
    get "product/add_wishlist_success" => "product/add_wishlist_success", as: :add_wishlist_success
    get "product/add_compare_success" => "product/add_compare_success", as: :add_compare_success
    get "san-pham/ket-qua-tim-kiem" => "product#search", as: :search
    get "san-pham/y-kien-khach-hang" => "product#testimonial", as: :testimonial_list
    get "san-pham/gui-y-kien-khach-hang" => "product#testimonialform", as: :testimonial_form
    get "san-pham/dac-biet" => "product#special", as: :special
    get "san-pham/:url/:st" => "product#view_all_product_by_status", as: :view_all_product_by_status
    # end product
    
    # resources
    resources :comments
    resources :newsletters
    resources :contacts
    # devise_for :users, skip: :omniauth_callbacks, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }
    devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
    resources :carts do
      collection do
        get "cart"
        get "use_voucher"
        get "shopping_cart_use_voucher"
        get "use_coupon"
      end
    end
    resources :line_items do
      collection do
        get "add_to_cart"
        get "add_cart_buy_now"
      end
    end
    resources :customers
    resources :orders
    resources :wish_lists do
      collection do
        get 'add_item'
      end
    end
    resources :line_item_compares do
      collection do
        get 'add_item'
      end
    end
    resources :compares
    resources :questions
    resources :comment_articles
    resources :feedbacks
    resources :testimonials
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
      resources :newsletters do
        collection do
          get 'search'
        end
      end
      resources :contacts do
        collection do
          get 'search'
        end
      end
      resources :wish_lists do
        collection do
          get 'search'
        end
      end
      resources :comments do
        collection do
          get 'search'
        end
      end
      resources :questions do
        collection do
          get 'search'
        end
      end
      resources :customers do
        collection do
          get 'search'
        end
      end
      resources :payment_methods do
        collection do
          get 'search'
        end
      end
      resources :delivery_methods do
        collection do
          get 'search'
        end
      end

      resources :comment_articles do
        collection do
          get 'search'
        end
      end
      resources :slideshows do
        collection do
          get 'search'
        end
      end
      resources :vouchers do
        collection do
          get 'search'
        end
      end
      resources :coupons do
        collection do
          get 'search'
        end
      end
      resources :testimonials do
        collection do
          get 'search'
        end
      end
      resources :companies
      resources :code_statuses do
        collection do
          get 'search'
        end
      end
    end
  end
end
