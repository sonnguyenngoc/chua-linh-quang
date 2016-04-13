class Manufacturer < ActiveRecord::Base
  mount_uploader :image_url, ManufacturerUploader
  validates :name, presence: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  def self.get_all_manufacturers
    self.all
  end
  
   def self.sort_by
    [
      ["Name","name"]
    ]
  end
  
  def self.sort_orders
    [
      ["DESC","desc"],
      ["ASC","asc"]
    ]
  end
  
end
