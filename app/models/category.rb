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
  
  def self.get_all_categories(params)
      if params[:category_id].present?
        self.find(params[:category_id]).children
      else
        self.where(level: 1)
      end
  end
  
  def self.get_categories
      self.all
  end
  
  def get_products_for_categories(params)
    category = Category.find(params[:category_id])
    records = Product.joins(:categories).where(categories: {id: category.get_all_related_ids}).uniq
    
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
    
    return records.where(is_show: true)
  end
  
  def get_current_level
    self.level
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
      ["ASC","asc"],
      ["DESC","desc"],
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
  
  def self.get_by_status(status, area, limit=5)
    cats = []
    if status == "new"
      query = Product.joins(:areas).get_active_products
      query.order("created_at DESC").first(19)
    else
      status == 'deal' or status == 'prominent' or status == 'imported' or status == "bestseller"
      query = Product.joins(:areas).where("products.status LIKE ?", "%#{status}%").get_active_products
    end
    query = query.where("areas.id = ?", area.id) if area.id.present?
    
    if !query.nil?
      query.each do |p|
        cats += p.categories.map(&:id)
      end
    end
    self.where(id: cats.uniq)[0..4]
  end
  
  # get json for tree draggable index
  def self.get_tree_json(current_user)
    arr = []
    Category.where(level: 1).order("ordered").each do |c|
      row = {"key" => c.id, "title" => "<span class='c-item' parent='' rel='#{c.id}' ordered='#{c.ordered}'>#{c.name}</span> #{c.html_actions(current_user)}", "expanded" => true, "folder" =>  true, "children" => []}
      c.children.order("ordered").each do |c2|
        child = {"key" => c2.id, "title" => "<span class='c-item' parent='#{c.id}' rel='#{c2.id}' ordered='#{c2.ordered}'>#{c2.name}</span> #{c2.html_actions(current_user)}", "expanded" => true, "folder" => true, "children" => []}
        c2.children.order("ordered").each do |c3|
          child["children"] << {"key" => c3.id, "title" => "<span class='c-item' parent='#{c2.id}' rel='#{c3.id}' ordered='#{c3.ordered}'>#{c3.name}</span> #{c3.html_actions(current_user)}", "expanded" => true, "folder" => true, "children" => []}
        end
        row["children"] << child
      end
      arr << row
    end
    return arr
  end
  
  def html_actions(current_user)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    str = ""
    str += ActionController::Base.helpers.link_to('| <i class="glyphicon glyphicon-edit"></i>'.html_safe, {controller: "admin/categories", action: "edit", id: self.id}) if current_user.can?(:update, self)
    str += " "
    # str += ActionController::Base.helpers.link_to('<i class="glyphicon glyphicon-trash"></i>'.html_safe, {controller: "admin/categories", action: "destroy", id: self.id}, "data-method" => "delete")
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
      c.update_column(:level, c.get_level)
    end

  end
  
  def self.get_three_cols_select(level, category=nil)
    if level == 1
      return Category.where(level: 1)
    elsif category.present?
      if level == category.get_level - 1
        return category.parent.first.parent.first.children
      end
      if level == category.get_level
        return category.parent.first.children
      end
      if level == category.get_level + 1
        return category.children
      end
    end
    []
  end
  
  def related_ids
    arr = [self.id]
    arr << self.parent.first.id if self.parent.present?
    arr << self.parent.first.parent.first.id if self.parent.present? and self.parent.first.parent.present?
    
    return arr
  end
  
end
