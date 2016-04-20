class ArticleCategoriesArticle < ActiveRecord::Base
  belongs_to :article
  belongs_to :article_category
end
