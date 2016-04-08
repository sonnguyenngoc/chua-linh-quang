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
  
  def get_name_area
    arr = [self.name]
    p = self.parent
    while !p.nil?
      arr.unshift p.name
      p = p.parent
    end
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
  
end
