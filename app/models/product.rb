class Product < ActiveRecord::Base
  validates :name, :price, :quantity, :unit, :manufacturer_id, :short_description, presence: true
  validates :code, :uniqueness => true
  
  has_many :order_details
  has_many :line_items, dependent: :destroy
  has_many :line_item_comparies, dependent: :destroy, class_name: "LineItemCompare"
  has_many :categories_products
  has_many :wish_lists, dependent: :destroy
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :areas
  belongs_to :manufacturer
  has_many :product_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |a| a[:image_url].blank? && a[:id].blank? }, :allow_destroy => true
  has_and_belongs_to_many :articles, dependent: :destroy
  belongs_to :user
  
  def self.get_active_products
    self.where("products.approved = true and products.is_show = true")
  end
  
  def self.get_products_for_manufacturer(params)
    records = self.get_active_products.where(manufacturer_id: params[:manufacturer_id])
    
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
      [I18n.t('st_deal'),"deal"],
      [I18n.t('st_prominent'),"prominent"],
      [I18n.t('st_bestseller'),"bestseller"],
      [I18n.t('st_new'),"new"],
      [I18n.t('st_imported'),"imported"],
      [I18n.t('st_sold_out'),"sold_out"],
    ]
  end
  
  def self.sort_by
    [
      [I18n.t('product_name'),"products.name"],
      [I18n.t('manufacturer_name'),"manufacturers.name"],
      [I18n.t('price'),"products.price"]
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
    records = self.get_active_products
    
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
        records = records.where("LOWER(CONCAT(products.name,' ',products.code)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "products.name"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records
  end
  
  #Filter, Sort
  def self.search_backend(params)
    records = self.all
    
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
    # status.present? ? I18n.t("#{status}").to_s.split(",") : ""
    arr = []
    status.to_s.split(",").each do |st|
      arr << I18n.t(st) if st.present?
    end
    return arr    
  end
  
  def split_statues
    I18n.t(self.status.split(","))
  end
  
  def display_statuses
    @html = ",<br />"
    statuses.join(@html).html_safe
  end
  
  #def self.get_by_category_status(category, area, status)
  #  records = self.joins(:areas).get_active_products
  #  
  #  if status == 'new'
  #    records = records.order("created_at DESC").limit(19)
  #    records = records.where("areas.id = ?", area.id) if area.id.present?
  #    records = records.joins(:categories).where(categories: {id: category})
  #  else
  #    records = records.where("products.status LIKE ?", "%#{status}%")
  #    records = records.where("areas.id = ?", area.id) if area.id.present?
  #    records = records.joins(:categories).where(categories: {id: category})
  #  end
  #  
  #  return records
  #end
  
  def self.get_by_bestseller
    records = self.get_active_products
    records = records.where("products.status LIKE ?", "%#{'bestseller'}%")
    records = records.order("updated_at DESC").first(3)
    return records
  end
  
  def self.get_by_deal
    records = self.get_active_products
    records = records.where("products.status LIKE ?", "%#{'deal'}%")
    return records
  end
  
  def self.get_by_new
    records = self.get_active_products
    records = records.order("created_at DESC")
    return records
  end
  
  def self.get_all_product_by_status(params)
    records = self.get_active_products
    if params[:st].present?
      if params[:st] == "new"
        records = records.order("created_at DESC")
      end
      if params[:st] == "deal" or params[:st] == "prominent" or params[:st] == "bestseller" or params[:st] == "imported"
        records = records.where("products.status LIKE ?", "%#{params[:st]}%")
      end
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
    has_status?(I18n.t('deal'))
  end
  
  def is_new?
    has_status?(I18n.t('new'))
  end
  
  def is_sold_out?
    has_status?(I18n.t('sold_out'))
  end
  
  def is_bestseller?
    has_status?(I18n.t('bestseller'))
  end
  
  def is_prominent?
    has_status?(I18n.t('prominent'))
  end
  
  def is_imported?
    has_status?(I18n.t('imported'))
  end
  
  # Display status label
  
  def display_is_new
    display = ""
    if is_new?
      display = "Mới"
    end
    return display
  end
  
  def display_is_bestseller
    display = ""
    if is_bestseller?
      display = "<div class=\"label_bestseller\"><div>Bán chạy</div></div>"
    end
    return display
  end
  
  def display_is_prominent
    display = ""
    if is_prominent?
      display = "<div class=\"label_hot\"><div>Nổi bật</div></div>"
    end
    return display
  end
  
  def display_is_imported
    display = ""
    if is_imported?
      display = "<div class=\"label_imported\"><div>Hàng nhập khẩu</div></div>"
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
  # End display status label
  
  # buy products
  def bought_products
    order_details.sum(:quantity)
  end
  
  # sum quantity
  def sum_quantity
    sum = 0
    order_details.each do |item|
      sum = sum + item.quantity
    end
    
    return sum
  end
end
