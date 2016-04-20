class Category < ActiveRecord::Base
  validates :name, presence: true
  
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
    self.all.order("ordered, created_at ASC")
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
  

  def self.get_by_status(status, limit=5)
    self.all.limit(5)
  end 
  # get json for tree draggable index
  def self.get_tree_json
    arr = []
    Category.where(level: 1).order("ordered").each do |c|
      row = {"key" => c.id, "title" => "<span class='c-item' parent='' rel='#{c.id}' ordered='#{c.ordered}'>#{c.name}</span> | #{c.html_actions}", "expanded" => true, "folder" =>  true, "children" => []}
      c.children.order("ordered").each do |c2|
        child = {"key" => c2.id, "title" => "<span class='c-item' parent='#{c.id}' rel='#{c2.id}' ordered='#{c2.ordered}'>#{c2.name}</span> | #{c2.html_actions}", "expanded" => true, "folder" => true, "children" => []}
        c2.children.order("ordered").each do |c3|
          child[:children] << {"key" => c3.id, "title" => "<span class='c-item' parent='#{c2.id}' rel='#{c3.id}' ordered='#{c3.ordered}'>#{c3.name}</span> | #{c3.html_actions}", "expanded" => true, "folder" => true, "children" => []}
        end
        row[:children] << child
      end
      arr << row
    end
    return arr
  end
  
  def html_actions
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    str = ActionController::Base.helpers.link_to('<i class="glyphicon glyphicon-edit"></i>'.html_safe, {controller: "admin/categories", action: "edit", id: self.id})
    str += " "
    str += ActionController::Base.helpers.link_to('<i class="glyphicon glyphicon-trash"></i>'.html_safe, {controller: "admin/categories", action: "destroy", id: self.id}, "data-method": "delete").html_safe
    str
  end
  
  # get level of category
  def get_level
    level = 1
    p = parent.first
    while !p.nil?
      level += 1
      p = p.parent.first
    end
    
    return level
  end
  
  # update all categories level
  def self.update_all_level
    Category.all.each do |c|
      c.update_attribute(:level, c.get_level)
    end

  end
  
end
