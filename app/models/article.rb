class Article < ActiveRecord::Base
  mount_uploader :image_url, ArticleUploader
  has_and_belongs_to_many :article_categories
  has_and_belongs_to_many :products
  has_many :comment_articles
  
  def self.get_lastest_blog_posts
    self.order("created_at DESC").first(3)
  end
  
  def self.get_all_blogs
    self.all.order("created_at DESC")
  end
  
  def self.get_blog_about_us
    records = self.joins(:article_categories).where(article_categories: {name: "Về chúng tôi"})
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
      ["Created At","created_at"]
    ]
  end
  
  def self.sort_orders
    [
      ["DESC","desc"],
      ["ASC","asc"],
    ]
  end
  
  #the highest product quality
  
  def self.get_highest_product_quality
    records = self.all
    records = records.where(code: "the_highest_product_quality")
    records.order("created_at DESC").first
    
    return records
  end
  
  #fast & free delivery
  def self.get_fast_free_delivery
    records = self.all
    records = records.where(code: "fast_free_delivery")
    records.order("created_at DESC").first
    
    return records
  end
  
  #safe & secure payment
  def self.get_safe_secure_order
    records = self.all
    records = records.where(code: "safe_secure_order")
    records.order("created_at DESC").first
    
    return records
  end
  
  #100% money back guaranteed
  def self.get_money_back
    records = self.all
    records = records.where(code: "money_back")
    records.order("created_at DESC").first
    
    return records
  end
  
  #get percent off fo reorder
  def self.get_percent_off
    records = self.all
    records = records.where(code: "get_5_percent_off")
    records.order("created_at DESC").first
    
    return records
  end
  
  #free pills on every order
  def self.get_favorable_gift
    records = self.all
    records = records.where(code: "favorable_gift")
    records.order("created_at DESC").first
    
    return records
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
