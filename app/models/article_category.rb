class ArticleCategory < ActiveRecord::Base
  validates :name, presence: true
  
  has_and_belongs_to_many :articles
  has_many :parent_article_categories, dependent: :destroy
  has_many :parent, through: :parent_article_categories, source: :parent
  has_many :child_article_categories, class_name: "ParentArticleCategory", foreign_key: "parent_id", dependent: :destroy
  has_many :children, through: :child_article_categories, source: :article_category
  
  def update_level(lvl)
    self.level = lvl
    self.save
  end
  
  def url_friendly
      self.name.unaccent.downcase.to_s.gsub(/[^0-9a-z ]/i, '').gsub(/ +/i, '-').strip
  end
  
  def self.get_all_parent_categories
    self.where("article_categories.level = 1").order("position asc")
  end
  
  def get_posts_for_categories(params)
    article_category = ArticleCategory.find(params[:category_id])
    records = Article.get_active_articles
    records = records.joins(:article_categories).where(article_categories: {id: article_category.get_all_related_ids}).uniq
    
    return records
  end
  
  def count_posts_for_categories
    records = Article.get_active_articles
    records = records.joins(:article_categories).where(article_categories: {id: self.get_all_related_ids}).uniq
    
    return records.count
  end
  
  def get_related_posts_for_categories(params)
    article_category = ArticleCategory.find(params[:category_id])
    records = Article.get_active_articles
    records = records.joins(:article_categories).where(article_categories: {id: article_category.get_all_related_ids}).uniq
    
    return records.first(9)
  end
  
  def get_all_related_ids
      arr = []
      arr << self.id
      self.children.each do |i1|
          arr << i1.id
          i1.children.each do |i2|
              arr << i2.id
              i2.children.each do |i3|
                  arr << i3.id
              end
          end 
      end
      
      return arr
  end
  
  def self.sort_by
    [
      [I18n.t('created_at'),"created_at"]
    ]
  end
  
  def self.sort_order
    [
      [I18n.t('asc'),"asc"],
      [I18n.t('desc'),"desc"],
    ]
  end
  
  #Filter, Sort
  def self.search(params)
    records = self.all

    #Search keyword filter
    if params[:keyword].present?
      records = records.where("LOWER(CONCAT(article_categories.name,' ',article_categories.description)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "article_categories.position"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end
  
end
