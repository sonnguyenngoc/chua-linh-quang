class Product < ActiveRecord::Base
  validates :name, :price, :quantity, :unit, :manufacturer_id, :short_description, presence: true
  before_destroy :ensure_not_referenced_by_any_line_item
  before_destroy :ensure_not_referenced_by_any_line_item_compare
  
  has_many :line_items
  has_many :line_item_comparies
  has_many :categories_products
  has_many :wish_lists
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :areas
  belongs_to :manufacturer
  has_many :product_images
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |a| a[:image_url].blank? && a[:id].blank? }, :allow_destroy => true
  has_and_belongs_to_many :articles
  
  def self.get_products_for_manufacturer(params)
    records = self.where(manufacturer_id: params[:manufacturer_id])
    
    return records
  end
  
  #
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
  
  def self.sort_order
    [
      ["ASC","asc"],
      ["DESC","desc"],      
    ]
  end
  
  #Filter, Sort
  def self.search(params)
    records = self.includes(:manufacturer)
    
    # Manufacturer filter
    if params[:manufacturer_id].present?
        records = records.where(manufacturer_id: params[:manufacturer_id])
    end
    
    #Category filter
    if params[:category_id].present?
        records = records.joins(:categories).where(categories: {id: params[:category_id]})
    end
    
    #Area filter
    if params[:area_id].present?
        records = records.joins(:areas).where(areas: {id: params[:area_id]})
    end
    
    #Status filter
    if params[:status].present?
        records = records.where("products.status LIKE ?", "%#{params[:status]}%")
    end
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(products.name) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "products.name"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end
  
  def get_main_image
    image = product_images.where(is_main: "True").order("updated_at DESC").first
    
  end
  
  def get_related_products
    cat_ids = []
    categories.each do |c|
      cat_ids += c.get_all_related_ids
    end
    records = Product.joins(:categories).where(categories: {id: cat_ids}).uniq
    
    return records
  end

  
  def statuses
    status.to_s.split(",")
  end
  
  def self.get_by_category_status(category, status, limit=5)
    records = self.all
    records = records.where("products.status LIKE ?", "%#{status}%")
    records = records.joins(:categories).where(categories: {id: category})
    return records
  end
  
  def wish_by? user
    wish_lists.exists? user_id: user
  end
  
  private
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
    
    # ensure that there are no line items compare referencing this product
    def ensure_not_referenced_by_any_line_item_compare
      if line_item_comparies.empty?
        return true
      else
        errors.add(:base, 'Compare of Line Items present')
        return false
      end
    end

end
