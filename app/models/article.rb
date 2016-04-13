class Article < ActiveRecord::Base
  mount_uploader :image_url, ArticleUploader
  has_and_belongs_to_many :article_categories
  
  def self.get_lastest_blog_posts
    self.order("created_at DESC").first(3)
  end
  
  def self.get_all_blogs
    self.all.order("created_at DESC")
  end
  
  def self.get_related_blog_posts(params)
    
  end
  
  def self.sort_by
    [
      ["Create At","create_at"]
    ]
  end
  
  def self.sort_orders
    [
      ["DESC","desc"],
      ["ASC","asc"]
    ]
  end
  
end
