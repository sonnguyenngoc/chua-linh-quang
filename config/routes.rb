Rails.application.routes.draw do
  devise_for :users
  
  scope "(:locale)", locale: /vi|en/, defaults: {locale: "vi"} do
    
    root "comming_soon#index"
    get "trang-chu.html" => "home#index", as: :home
    get "bai-viet/(:category_name)-:category_id.html" => "category#index", as: :category
    get "tin-nong.html" => "category#hot_news", as: :hot_news
    get "ket-qua-tim-kiem-bai-viet.html" => "category#posts_search", as: :posts_search
    get "bai-viet/(:category_name)-:category_id/(:post_name)-:post_id.html" => "post_detail#index", as: :post_detail
    get "thu-vien-anh.html" => "gallery#picture", as: :gallery_picture
    get "thu-vien-nhac.html" => "gallery#music", as: :gallery_music
    get "thu-vien-video.html" => "gallery#video", as: :gallery_video
    get "thu-vien-anh/(:picture_name)-:picture_id.html.html" => "gallery#picture_detail", as: :picture_detail
    get "thu-vien-nhac/(:music_name)-:music_id.html.html" => "gallery#music_detail", as: :music_detail
    get "thu-vien-video/(:video_name)-:video_id.html.html" => "gallery#video_detail", as: :video_detail
    get "lien-he.html" => "contact#index", as: :contact
    get "lien-he/thanh-cong.html" => "contact#thankyou", as: :contact_thankyou
    
    # form create contact
    resources :contacts
    
    namespace :admin, path: "quan-tri" do
      get "/" => "main#index"
      scope(:path_names => { :new => "tao-moi", :edit => "chinh-sua" }) do
        resources :shopping_carts, path: "gio-hang"
        resources :products, path: "danh-sach-san-pham" do
          collection do
            get 'search'
            get 'search_backend'
            get 'approve'
            get 'add_related_articles'
          end
        end
        resources :categories, path: "chuyen-muc-san-pham" do
          collection do
            get 'search'
            get 'update_parent_order'
            get 'three_cols_select'
          end
        end
        resources :manufacturers, path: "nha-cung-cap" do
          collection do
            get 'search'
          end
        end
        resources :articles, path: "bai-viet" do
          collection do
            get 'search'
            post 'upload_image_video'
            get 'approve'
            get 'add_related_products'
          end
        end
        resources :article_categories, path: "chuyen-muc-bai-viet" do
          collection do
            get 'search'
          end
        end
        resources :areas, path: "khu-vuc" do
          collection do
            get 'search'
          end
        end
        resources :orders, path: "don-hang" do
          collection do
            get 'search'
          end
          collection do
            get 'pending'
          end
          collection do
            get 'finish'
          end
          collection do
            get 'cancel'
          end
        end
        resources :newsletters, path: "dang-ky-nhan-tin-moi" do
          collection do
            get 'search'
          end
        end
        resources :contacts, path: "lien-he" do
          collection do
            get 'search'
          end
        end
        resources :wish_lists, path: "san-pham-yeu-thich" do
          collection do
            get 'search'
          end
        end
        resources :comments, path: "binh-luan-san-pham" do
          collection do
            get 'search'
          end
        end
        resources :users , path: "nguoi-dung" do
          collection do
            get 'search'
          end
        end
        resources :questions, path: "cau-hoi-san-pham" do
          collection do
            get 'search'
          end
        end
        resources :customers, path: "khach-hang" do
          collection do
            get 'search'
          end
        end
        resources :payment_methods, path: "hinh-thuc-thanh-toan" do
          collection do
            get 'search'
          end
        end
        resources :delivery_methods, path: "hinh-thuc-giao-hang" do
          collection do
            get 'search'
          end
        end
        resources :comment_articles, path: "binh-luan-bai-viet" do
          collection do
            get 'search'
          end
        end
        resources :slideshows, path: "trinh-chieu" do
          collection do
            get 'search'
          end
        end
        resources :vouchers, path: "phieu-mua-hang" do
          collection do
            get 'search'
          end
        end
        resources :coupons, path: "ma-giam-gia" do
          collection do
            get 'search'
          end
        end
        resources :testimonials, path: "y-kien-khach-hang" do
          collection do
            get 'search'
          end
        end
        resources :companies, path: "thong-tin-chua-linh-quang"
        resources :user_groups, path: "nhom-nguoi-dung"
        get "tru-so-chinh" => "companies#head_office", as: :head_office
        resources :options, path: "cai-dat"
        resources :code_statuses, path: "ma-bai-viet" do
          collection do
            get 'search'
          end
        end
        resources :galleries, path: "thu-vien-anh"
        resources :banners, path: "banner-website"
        resources :albums, path: "album"
      end
    end
  end
end
