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
