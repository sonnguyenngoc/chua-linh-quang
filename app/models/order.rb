class Order < ActiveRecord::Base
  has_many :order_details, dependent: :destroy
  has_one :customer, dependent: :destroy
  has_one :order_delivery, dependent: :destroy
  
  #save cart
  def save_from_cart(cart)
    cart.line_items.each do |item|
      self.order_details.create(product_id: item.product_id, quantity: item.quantity)
    end
  end
  

  #total price orders (backend)
  def total_order
    total = 0.0
    self.order_details.each do |tt|
      total += tt.total
    end
    return total
  end
  
  def self.sort_by
    [
      ["Created At", "created_at"]
    ]
  end
  def self.sort_order
    [
      ["ASC","asc"],
      ["DESC","desc"],
    ]
  end
  
  def self.search(params)
    records = self.all
    
    # Customer filter
    if params[:customer_id].present?
        records = records.where(customer_id: params[:customer_id])
    end
    
    #Product filter
    if params[:product_id].present?
        records = records.joins(:order_details).where(order_details: {id: params[:product_id]})
    end
    
    #From Date filter
    if params[:from_date].present? && params[:to_date].present?
      records = records.where('created_at >= ?', params[:from_date].to_date.beginning_of_day)
                        .where('created_at <= ?', params[:to_date].to_date.end_of_day)
    end
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(orders.name) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "orders.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end

  #get order for user
  def self.get_by_order(current_user)
    records = self.all
    records = records.where(user_id: {id: params[:current_id]})
    return records
  end
  
  def total
    amount = 0.0
    order_details.each do |od|
      amount += od.total
    end
    return amount
  end

end
