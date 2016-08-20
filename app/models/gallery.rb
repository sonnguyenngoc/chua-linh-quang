class Gallery < ActiveRecord::Base
    mount_uploader :image_url, GalleryUploader
    has_many :gallery_images, dependent: :destroy
    accepts_nested_attributes_for :gallery_images, :reject_if => lambda { |a| a[:image_url].blank? && a[:id].blank? }, :allow_destroy => true
    
    def self.get_all_galleries
        self.all.order("created_at DESC")
    end
    
    def self.get_newest_galleries
        self.all.order("created_at DESC").first(5)
    end
    
    def url_friendly
      self.title.unaccent.downcase.to_s.gsub(/[^0-9a-z ]/i, '').gsub(/ +/i, '-').strip
  end
end
