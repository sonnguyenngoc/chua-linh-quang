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
end
