class Area < ActiveRecord::Base
  validates :name, presence: true
  
  has_and_belongs_to_many :products
  
  has_many :children, class_name: "Area", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Area"
  
  def self.get_all_areas
    self.order("name DESC, created_at DESC")
  end
  
  def update_level(lvl)
    self.level = lvl
    self.save
  end
  
  def get_parent_name
    arr = []
    p = self.parent
    while !p.nil?
      arr.unshift p.name
      p = p.parent
    end
    return arr.join("-")
  end
  
  def get_name_area
    arr = [self.name]
    arr.unshift get_parent_name if !get_parent_name.empty?
    return arr.join("-")
  end
  
  def self.get_select_options
    arr = []
    self.where(parent_id: nil).each do |a|
      arr << a
      a.children.each do |a2|
        arr << a2
        a2.children.each do |a3|
          arr << a3
        end
      end
    end
    return arr
  end
  
  #
  def self.sort_by
    [
      ["Name","areas.name"]
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
        records = records.joins(:areas).where("areas.parent_id = ?", params[:parent_id])
    end
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(areas.name) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "areas.name"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end
  
  # get level of category
  def get_level
    level = 1
    p = parent
    while !p.nil?
      level += 1
      p = p.parent
    end
    
    return level
  end
  
  def self.get_list_province_city
    self.all.where(level: 2)
  end
  
  # update all categories level
  def self.update_all_level
    Area.all.each do |c|
      c.update_attribute(:level, c.get_level)
    end

  end
  
end
