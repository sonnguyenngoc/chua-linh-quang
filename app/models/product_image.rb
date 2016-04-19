class ProductImage < ActiveRecord::Base
  mount_uploader :image_url, ProductUploader
end
