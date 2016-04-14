class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  
  has_and_belongs_to_many :products
  has_many :parent_categories, dependent: :destroy
  has_many :parent, through: :parent_categories, source: :parent
  has_many :child_categories, class_name: "ParentCategory", foreign_key: "parent_id", dependent: :destroy
  has_many :children, through: :child_categories, source: :category
  
  def update_level(lvl)
    self.level = lvl
    self.save
  end
  
  def self.get_all_categories
    self.all.order("created_at ASC")
  end
  
  def get_products_for_categories(params)
    category = Category.find(params[:category_id])
    records = Product.joins(:categories).where(categories: {id: category.get_all_related_ids}).uniq
    
    return records
  end
  
  def get_all_related_ids
      arr = []
      arr << self.id
      self.children.each do |i1|
          arr << i1.id
          i1.children.each do |i2|
              arr << i2.id
              i2.children.each do |i3|
                  arr << i3.id
              end
          end 
      end
      
      return arr
  end
  
  #
  def self.sort_by
    [
      ["Name","categories.name"]
    ]
  end
  
  def self.sort_order
    [
      ["DESC","desc"],
      ["ASC","asc"]
    ]
  end
  
  #Filter, Sort
  def self.search(params)
    records = self.all
    
    #Parent filter
    if params[:parent_id].present?
        records = records.joins(:parent_categories).where("parent_categories.parent_id = ?", params[:parent_id])
    end
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(categories.name) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "categories.name"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end
  
end
