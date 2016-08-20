class Article < ActiveRecord::Base
  validates :title, :content, :image_url, presence: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  mount_uploader :image_url, ArticleUploader
  mount_uploader :image_url_full_width, ArticleUploader
  has_and_belongs_to_many :article_categories
  has_and_belongs_to_many :products
  has_many :comment_articles, dependent: :destroy
  belongs_to :code_status
  has_and_belongs_to_many :areas
  
  def self.get_active_articles
    self.where("articles.approved = true and articles.is_show = true").order("posted_at DESC")
  end
  
  def url_friendly
      self.title.unaccent.downcase.to_s.gsub(/[^0-9a-z ]/i, '').gsub(/ +/i, '-').strip
  end
  
  # 0 - hot news
    def self.get_hot_news # get 12 items
        records = self.get_active_articles
        records = records.where("articles.is_mine = true").first(15)
        
        records
    end
  # End hot news
  
  # 1 - category_1
    def self.get_all_category_1 # get 9 items phật sự
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_1'").first(5)
        
        records
    end
    def self.get_newest_category_1 # get 9 items phật sự
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_1'").first(3)
        
        records
    end
  # End category_1
  
  # 2 - category_2
    def self.get_all_category_2 # get 9 items phật pháp
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_2'
                                                            or article_categories.style = 'category_2.1'
                                                            or article_categories.style = 'category_2.2'
                                                            or article_categories.style = 'category_2.3'
                                                            or article_categories.style = 'category_2.4'
                                                            or article_categories.style = 'category_2.5'").first(5)
        
        records
    end
  # End category_2
  
  # 3 - category_3
    def self.get_all_category_3 # get 9 items tin tức
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_3'").first(5)
        
        records
    end
  # End category_3
  
  # 1 - category_1
    def self.get_all_category_4 # get 9 items từ thiện
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_4'").first(5)
        
        records
    end
  # End category_1
  
  # 5 - category_5
    def self.get_all_category_5 # get 5 items văn hóa
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_5'
                                                            or article_categories.style = 'category_5.1'
                                                            or article_categories.style = 'category_5.2'").first(7)
        
        records
    end
  # End category_5
  
  # 6 - category_6
    def self.get_all_category_6 # get 5 items văn hóa
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_6'").first(7)
        
        records
    end
  # End category_6
  
  # 3 - Buddhist Book
  
    def self.get_all_buddhist_book_blogs
      records = self.get_active_articles
      records = records.joins(:article_categories).where("article_categories.name = 'Bước Đầu Học Phật' or article_categories.name = 'Giáo Pháp' or article_categories.name = 'Tịnh Độ Tông' or article_categories.name = 'Thiền Tông' or article_categories.name = 'Mật Tông'  or article_categories.name = 'Phật Pháp'")
      
      records.uniq
    end
    
    def self.get_all_buddhist_book_sub_1_blogs
      records = self.get_active_articles
      records = records.joins(:article_categories).where("article_categories.name = 'Bước Đầu Học Phật'")
      
      records
    end
    
    def self.get_all_buddhist_book_sub_2_blogs
      records = self.get_active_articles
      records = records.joins(:article_categories).where("article_categories.name = 'Giáo Pháp'")
      
      records
    end
    
    def self.get_all_buddhist_book_sub_3_blogs
      records = self.get_active_articles
      records = records.joins(:article_categories).where("article_categories.name = 'Tịnh Độ Tông'")
      
      records
    end
    
    def self.get_all_buddhist_book_sub_4_blogs
      records = self.get_active_articles
      records = records.joins(:article_categories).where("article_categories.name = 'Thiền Tông'")
      
      records
    end
    
    def self.get_all_buddhist_book_sub_5_blogs
      records = self.get_active_articles
      records = records.joins(:article_categories).where("article_categories.name = 'Mật Tông'")
      
      records
    end
  
  # End Buddhist Book
  
  # 4 - News
    def self.get_all_news
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.name = 'Tin Tức'")
        
        records
    end
  # End News
  
  # 5 - Charity
    def self.get_all_charity_blogs
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.name = 'Từ Thiện'")
        
        records
    end
  # End Charity
  
  # 6 - Cultural
      def self.get_all_cultural_blogs
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.name = 'Góp Nhặt Cát Đá' or article_categories.name = 'Văn Học - Nghệ Thuật' or article_categories.name = 'Văn Hóa'")
        
        records.uniq
      end
      
      def self.get_all_cultural_sub_1_blogs
        records = self.get_active_articles
        records = records.joins(:article_categories).where(article_categories: { name: 'Góp Nhặt Cát Đá' })
        
        records
      end
      
      def self.get_all_cultural_sub_2_blogs
        records = self.get_active_articles
        records = records.joins(:article_categories).where(article_categories: { name: 'Văn Học - Nghệ Thuật' })
        
        records
      end   
  # End Cultural
  
  # 7 - Buddhist Family
    def self.get_all_buddhist_family_blogs
      records = self.get_active_articles
      records = records.joins(:article_categories).where("article_categories.name = 'GĐPT Linh Quang'")
      
      records
    end
  # End Buddhist Family
  
  def self.get_lastest_posts
    self.get_active_articles.first(12)
  end
  
  def self.get_lastest_buddhist_news
    self.get_all_buddhist_news.first(4)
  end
  
  def self.get_lastest_cultural_news
    self.get_all_cultural_blogs.first(4)
  end
  
  def self.home_buddhist_news_first
    self.get_all_buddhist_news.first
  end
  
  def self.home_buddhist_news
    #self.get_all_buddhist_news.offset(1).first(4)
    self.get_all_buddhist_news.first(3)
  end
  
  def self.home_buddhist_book_blogs
    self.get_all_buddhist_book_blogs.first(3)
  end
  
  def self.home_news
    self.get_all_news.first(3)
  end
  
  def self.home_charity_blogs
    self.get_all_charity_blogs.first(3)
  end
  
  def self.home_cultural_blogs
    self.get_all_cultural_blogs.first(3)
  end
  
  def self.home_buddhist_family_blogs
    self.get_all_buddhist_family_blogs.first(3)
  end
  
  def split_tags
    tags.split(",").map {|s| s.to_s }
  end
  
  def self.get_all_blogs
    self.all.joins(:code_status).where("code_statuses.title = 'news' and articles.approved = true").order("created_at DESC")
  end
  
  def self.get_blog_about_us
    records = self.joins(:code_status).where("code_statuses.title = 'about_us' and articles.approved = true")
    records.order("created_at").first
    
    return records
  end
  
  def get_related_blogs
    cat_ids = []
    article_categories.each do |c|
      cat_ids += c.get_all_related_ids
    end
    records = Article.joins(:article_categories).where(article_categories: {id: cat_ids}).uniq
    records = Article.joins(:code_status).where("code_statuses.title = 'news'")
    return records
  end
  
  def self.sort_by
    [
      [I18n.t('created_at'),"created_at"]
    ]
  end
  
  def self.sort_orders
    [
      [I18n.t('desc'),"desc"],
      [I18n.t('asc'),"asc"],
    ]
  end
  
  #the highest product quality
  def self.get_highest_product_quality
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'the_highest_product_quality' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #the highest product quality
  def self.get_privacy_policy
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'privacy_policy' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #the highest product quality
  def self.get_delivery_information
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'delivery_information' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #the highest product quality
  def self.get_terms_conditions
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'terms_conditions' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #faq
  def self.get_faq
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'faq' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #fast & free delivery
  def self.get_fast_free_delivery
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'fast_free_delivery' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #safe & secure payment
  def self.get_safe_secure_order
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'safe_secure_order' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #100% money back guaranteed
  def self.get_money_back
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'money_back' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #get percent off fo reorder
  def self.get_percent_off
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'get_5_percent_off' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #free pills on every order
  def self.get_favorable_gift
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'favorable_gift' })
    records.order("created_at DESC").first
    
    return records
  end
  
  # customer_support_center
  def self.get_customer_support_center
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'customer_support_center' })
    records.order("created_at DESC").first
    
    return records
  end
  
  # payment_policy
  def self.get_payment_policy
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'payment_policy' })
    records.order("created_at DESC").first
    
    return records
  end
  
  # delivery_policy
  def self.get_delivery_policy
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'delivery_policy' })
    records.order("created_at DESC").first
    
    return records
  end
  
  # warranty_policy
  def self.get_warranty_policy
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'warranty_policy' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #get footer about us
  def self.get_footer_about_us
    records = self.get_active_articles
    records = records.joins(:code_status).where(code_statuses: { title: 'about_us' })
    records.order("created_at DESC").first
    
    return records
  end
  
  #banner event on top
  def self.get_banner_event_top
    records = self.where("articles.approved = true and articles.is_show = true")
    records = records.joins(:code_status).where(code_statuses: { title: 'banner_event_top' })
    
    return records.last
  end
  
  #banner public relations by provinces/areas
  def self.get_banner_by_area(current_area)
    if !current_area.id.nil?
      records = self.where("articles.approved = true and articles.is_show = true")
      records = records.joins(:code_status).where(code_statuses: { title: 'public_relations' })
      records = records.joins(:areas).where(areas: {id: current_area.id}) 
      return records.last
    else
      nil
    end
  end
  
  def self.get_by_area
    records = self.all
    return records
  end
  
  #keywords
  def keywords
    self.tags.split(",")
  end
  
  def self.get_meta_keywords(params)
    self.where(id: params[:article_category_id])
  end
  
  def self.get_keyword_article
      self.all.joins(:code_status).where(code_statuses: { title: 'keywords' }).first 
  end
  
  #Filter, Sort
  def self.search(params)
    records = self.all
    
    #Category filter
    if params[:article_category_id].present?
        records = records.joins(:article_categories).where(article_categories: {id: params[:article_category_id]})
    end
    
    #Code statuses filter
    if params[:code_statuses_id].present?
        records = records.joins(:code_status).where(code_statuses: {id: params[:code_statuses_id]})
    end

    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(articles.title) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "articles.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end
  
end
