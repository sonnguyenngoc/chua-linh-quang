class Product < ActiveRecord::Base
  validates :name, :price, :quantity, :unit, :manufacturer_id, :short_description, presence: true
  before_destroy :ensure_not_referenced_by_any_line_item
  
  has_many :line_items
  has_many :categories_products
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
  
  def get_main_image
    product_images.where(is_main: "True").order("updated_at DESC").first
  end
  
  def get_related_products
    cat_ids = []
    categories.each do |c|
      cat_ids += c.get_all_related_ids
    end
    records = Product.joins(:categories).where(categories: {id: cat_ids}).uniq
    
    return records
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

end
