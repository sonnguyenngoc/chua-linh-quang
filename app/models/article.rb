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
    self.where("articles.approved = true and articles.is_show = true").order("created_at DESC")
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
    def self.get_all_hot_news # get 12 items
        records = self.where("articles.approved = true and articles.is_show = true").order("posted_at DESC")
        records = records.where("articles.is_mine = true")
        
        records
    end
  # End hot news
  
  # 1 - category_1
    def self.get_all_category_1
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_1'").first(5)
        
        records
    end
    def self.get_newest_category_1
        records = self.get_active_articles
        records = records.joins(:article_categories).where("article_categories.style = 'category_1'").first(4)
        
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
    self.get_active_articles.first(20)
  end
  
  def self.sort_by
    [
      [I18n.t('created_at'),"posted_at"]
    ]
  end
  
  def self.sort_orders
    [
      [I18n.t('desc'),"desc"],
      [I18n.t('asc'),"asc"],
    ]
  end
  
  #Filter, Sort
  def self.search(params)
    records = self.where("articles.approved = true and articles.is_show = true").order("posted_at DESC")

    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(articles.title) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    return records   
  end
  
end
