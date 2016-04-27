class ArticlesProduct < ActiveRecord::Base
  belongs_to :article
  belongs_to :product
end
