class Slideshow < ActiveRecord::Base
  validates :title_1, :color_1, :title_2, :color_2, :style, presence: true
  validates :image_url, presence: true, on: :create
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  mount_uploader :image_url, SliderUploader
  
  def self.get_all_slides
    self.all.order("created_at DESC")
  end
end
