class Article < ActiveRecord::Base
  validates :title, :content, presence: true
  validates :image_url, presence: true
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
    self.where("articles.approved = true")
  end
  
  def self.get_lastest_blog_posts
    self.joins(:code_status).where("code_statuses.title = 'news' and articles.approved = true").first(3)
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
    
    return records
  end
  
  def self.sort_by
    [
      [I18n.t('created_at'),"created_at"]
    ]
  end
  
  def self.sort_orders
    [
      [I18n.t('asc'),"asc"],
      [I18n.t('desc'),"desc"],
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
