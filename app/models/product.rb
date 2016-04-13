class Product < ActiveRecord::Base
  validates :name, :price, :quantity, :unit, :manufacturer_id, :short_description, presence: true
  
  belongs_to :category
  has_many :categories_products
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :areas
  belongs_to :manufacturer
  has_many :product_images
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |a| a[:image_url].blank? && a[:id].blank? }, :allow_destroy => true

  def self.get_products_for_manufacturer(params)
    records = self.where(manufacturer_id: params[:manufacturer_id])
    
    return records
  end
  
  def self.status_options
    [
      ["Deal","deal"],
      ["New","new"],
      ["Featured","featured"],
      ["Bestseller","bestseller"]
    ]
  end
  
  def self.sort_by
    [
      ["Product","products.name"],
      ["Manufacturer","manufacturers.name"],
      ["Price","products.price"]
    ]
  end
  
  def self.sort_orders
    [
      ["ASC","asc"],
      ["DESC","desc"],      
    ]
  end
  
  def self.search(params)
    records = self.includes(:manufacturer)
    
    # Manufacturer filter
    if params[:manufacturer_id].present?
        records = records.where(manufacturer_id: params[:manufacturer_id])
    end
    
    if params[:category_id].present?
        records = records.joins(:categories).where(categories: {id: params[:category_id]})
    end
    
    if params[:area_id].present?
        records = records.joins(:areas).where(areas: {id: params[:area_id]})
    end
    
    if params[:status].present?
        records = records.where("products.status LIKE ?", "%#{params[:status]}%")
    end
    
    if params[:keyword].present?
        records = records.where("LOWER(products.name) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "products.name"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    
    
    return records   
  end
    
end
