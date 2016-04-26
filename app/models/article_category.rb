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
  
  def get_blogs_for_categories(params)
    article_category = ArticleCategory.find(params[:article_category_id])
    records = Article.joins(:article_categories).where(article_categories: {id: article_category.get_all_related_ids}).uniq
    
    return records
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
      ["Created At","created_at"]
    ]
  end
  
  def self.sort_order
    [
      ["DESC","desc"],
      ["ASC","asc"]
    ]
  end
  
  #Filter, Sort
  def self.search(params)
    records = self.all

    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(article_categories.name) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "article_categories.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end
  
end
