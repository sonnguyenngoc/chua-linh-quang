class Article < ActiveRecord::Base
  mount_uploader :image_url, ArticleUploader
  has_and_belongs_to_many :article_categories
end
