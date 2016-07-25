Rails.application.routes.draw do
  devise_for :users
  
  scope "(:locale)", locale: /vi|en/, defaults: {locale: "vi"} do
    
    root "coming_soon#index"
    
    # home
    get 'trang-chu.html' => "home#index", as: :home
    
    # buddhist_news
    get 'phat-su.html' => 'buddhist_news#index', as: :buddhist_news
    
    # buddhist_book
    get 'phat-phap.html' => 'buddhist_book#index', as: :buddhist_book
    get 'phat-phap/buoc-dau-hoc-phat.html' => 'buddhist_book#buddhist_book_sub_1', as: :buddhist_book_sub_1
    get 'phat-phap/giao-phap.html' => 'buddhist_book#buddhist_book_sub_2', as: :buddhist_book_sub_2
    get 'phat-phap/tinh-do-tong.html' => 'buddhist_book#buddhist_book_sub_3', as: :buddhist_book_sub_3
    get 'phat-phap/thien-tong.html' => 'buddhist_book#buddhist_book_sub_4', as: :buddhist_book_sub_4
    get 'phat-phap/mat-tong.html' => 'buddhist_book#buddhist_book_sub_5', as: :buddhist_book_sub_5
    
    # news
    get 'tin-tuc.html' => "news#index", as: :news
    
    # charity
    get 'tu-thien.html' => "charity#index", as: :charity
    
    # cultural
    get 'van-hoa.html' => "cultural#index", as: :cultural
    get 'van-hoa/gop-nhat-cat-da.html' => "cultural#cultural_sub_1", as: :cultural_sub_1
    get 'van-hoa/van-hoc-nghe-thuat.html' => "cultural#cultural_sub_2", as: :cultural_sub_2
    get 'van-hoa/thu-vien-anh.html' => "cultural#cultural_sub_3", as: :cultural_sub_3
    get 'van-hoa/thu-vien-anh/(:title)-:gallery_id.html' => "cultural#gallery_detail", as: :gallery_detail
    get 'van-hoa/thu-vien-nhac.html' => "cultural#cultural_sub_4", as: :cultural_sub_4
    
    # buddhist_family
    get 'gdpt-linh-quang.html' => "buddhist_family#index", as: :buddhist_family
    
    # contact
    get 'lien-he.html' => "contact#index", as: :contact
    get 'lien-he/gui-thanh-cong.html' => "contact#send_contact_success", as: :send_contact_success
    
    # blog_detail
    get 'chi-tiet-bai-viet/(:title)-:blog_id.html' => "blog_detail#index", as: :blog_detail
    
    # feeback
    get 'bao-loi-gop-y.html' => "feedback#index", as: :feedback
    
    # form create
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
      end
    end
  end
end
