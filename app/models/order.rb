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
  
  #total price orders with voucher and voucher (backend)
  def total_with_voucher_coupon
    total = 0.0
    self.order_details.each do |tt|
      total += tt.total
    end
    
    if !self.voucher_price.nil?
      total = total - voucher_price
    end
    
    if !self.coupon_price.nil?
      total = total - coupon_price
    end
    
    return total
  end
  
  def self.sort_by
    [
      [I18n.t('created_at'), "orders.created_at"]
    ]
  end
  def self.sort_order
    [
      [I18n.t('asc'),"asc"],
      [I18n.t('desc'),"desc"],
    ]
  end
  
  def self.get_order_pending
    records = self.all
    records = records.where("LOWER(orders.status) LIKE ?", "pending")
    return records
  end
  def self.search(params)
    records = self.all
    
    # Customer filter
    if params[:customer_id].present?
        records = records.includes(:customer).where(customers: {id: params[:customer_id]})
    end
    
    #Product filter
    if params[:product_id].present?
        records = records.joins(:order_details).where(order_details: {product_id: params[:product_id]})
    end
    
    #From Date filter
    if params[:from_date].present? && params[:to_date].present?
      records = records.where('orders.created_at >= ?', params[:from_date].to_date.beginning_of_day)
                        .where('orders.created_at <= ?', params[:to_date].to_date.end_of_day)
    end
    #Filter by Status
    if params[:status].present?
        if params[:status] == "all"
          records = records
        else
          records = records.where("LOWER(orders.status) LIKE ?", "#{params[:status]}")
        end
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
  
  def discount
    discount = 0.0
    discount = voucher_price.to_f + coupon_price.to_f
    return discount
  end
  
  def total_payment
    ttpm = 0.0
    ttpm = total - discount
    return ttpm
  end
  
  def display_class_status
    display = "label label-info"
    if self.status == "pending"
      display = "label label-info"
    end
    if self.status == "finished"
      display = "label label-success"
    end
    if self.status == "cancel"
      display = "label label-default"
    end
    return display.html_safe
  end

end
