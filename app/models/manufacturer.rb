class Manufacturer < ActiveRecord::Base
  mount_uploader :image_url, ManufacturerUploader
  validates :name, presence: true
  validates :image_url, presence: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  def self.get_all_manufacturers
    self.all
  end
  
  #
   def self.sort_by
    [
      [I18n.t('manufacturer_name'),"manufacturers.name"]
    ]
  end
  
  def self.sort_order
    [
      [I18n.t('asc'),"asc"],
      [I18n.t('desc'),"desc"],
    ]
  end
  
  #Filter, Sort
  def self.search(params)
    records = self.all

    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(manufacturers.name) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "manufacturers.name"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end
  
end
