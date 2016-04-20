class ParentArticleCategory < ActiveRecord::Base
  belongs_to :article_category
  belongs_to :parent, class_name: "ArticleCategory"
end
