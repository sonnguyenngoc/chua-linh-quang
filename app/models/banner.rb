class Banner < ActiveRecord::Base
  mount_uploader :image_url, GalleryUploader
  
  def self.get_main_banner
    self.order("created_at DESC").first
  end
end
