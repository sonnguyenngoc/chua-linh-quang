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
  has_many :comments, dependent: :destroy
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |a| a[:image_url].blank? && a[:id].blank? }, :allow_destroy => true
  has_and_belongs_to_many :articles
  
  def self.get_products_for_manufacturer(params)
    records = self.where(manufacturer_id: params[:manufacturer_id])
    
    if params[:sort_group] == "name_asc"
      records = records.order("products.name ASC")
    end
    
    if params[:sort_group] == "name_desc"
      records = records.order("products.name DESC")
    end
    
    if params[:sort_group] == "price_asc"
      records = records.order("products.price ASC")
    end
    
    if params[:sort_group] == "price_desc"
      records = records.order("products.price DESC")
    end
    
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
    
    #sorting search_page (frontend)
    if params[:sort_group] == "name_asc"
      records = records.order("products.name ASC")
    end
    
    if params[:sort_group] == "name_desc"
      records = records.order("products.name DESC")
    end
    
    if params[:sort_group] == "price_asc"
      records = records.order("products.price ASC")
    end
    
    if params[:sort_group] == "price_desc"
      records = records.order("products.price DESC")
    end
    #end sorting search_page (frontend)
    
    # Manufacturer filter
    if params[:manufacturer_id].present?
        records = records.where(manufacturer_id: params[:manufacturer_id])
    end
    
    #Category filter
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      records = records.joins(:categories).where(categories: {id: category.get_all_related_ids})
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
  
  def display_statuses
    @html = "<br />"
    statuses.join(@html).html_safe
  end
  
  def self.get_by_category_status(category, status)
    records = self.all
    records = records.where("products.status LIKE ?", "%#{status}%")
    records = records.joins(:categories).where(categories: {id: category})
    return records
  end
  
  def self.get_by_bestseller
    records = self.all
    records = records.where("products.status LIKE ?", "%#{'bestseller'}%")
    records = records.order("updated_at DESC").first(3)
    return records
  end
  
  def self.get_by_deal
    records = self.all
    records = records.where("products.status LIKE ?", "%#{'deal'}%")
    return records
  end
  
  def self.get_by_new
    records = self.all
    records = records.where("products.status LIKE ?", "%#{'new'}%")
    return records
  end
  
  def self.get_all_product_by_status(params)
    records = self.all
    if params[:st].present?
      records = records.where("products.status LIKE ?", "%#{params[:st]}%")
    end
    
    if params[:sort_group].present?
      records = records.order(params[:sort_group])
    end
    #
    #if params[:sort_group] == "name_desc"
    #  records = records.order("products.name DESC")
    #end
    #
    #if params[:sort_group] == "price_asc"
    #  records = records.order("products.price ASC")
    #end
    #
    #if params[:sort_group] == "price_desc"
    #  records = records.order("products.price DESC")
    #end
    
    return records
  end
  
  def wish_by? user
    wish_lists.exists? user_id: user
  end
  
  #average stars - count stars
  def count_stars
    arr = []
    self.comments.each do |item|
      arr << item.star
    end
    
    return arr
  end
  
  #average stars
  def average_stars
    if count_stars.length > 0
      sum = 0
      total_stars = count_stars.each { |b| sum += b }
      average = sum / count_stars.length
    end
    
    return average
  end
  
  def has_status?(status)
    statuses.include?(status)
  end
  
  def is_deal?
    has_status?("deal")
  end
  
  def is_new?
    has_status?("new")
  end
  
  def is_sold_out?
    has_status?("sold_out")
  end
  
  def is_bestseller?
    has_status?("bestseller")
  end
  
  def display_is_new
    display = ""
    if is_new?
      display = "Mới"
    end
    if is_bestseller?
      display = "Bán chạy"
    end
    return display
  end
  
  def display_is_sold_out
    display = ""
    if is_sold_out?
      display = "Tạm hết hàng"
    end
    return display
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
