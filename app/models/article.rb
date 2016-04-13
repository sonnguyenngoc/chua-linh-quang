class Article < ActiveRecord::Base
  mount_uploader :image_url, ArticleUploader
  has_and_belongs_to_many :article_categories
  has_and_belongs_to_many :products
  
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
  
end
