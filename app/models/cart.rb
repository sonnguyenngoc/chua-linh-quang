class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
  def add_product(product_id, quantity)
    current_item = line_items.find_by(product_id: product_id)
    
    if current_item
      if quantity.present?
        current_item.quantity += quantity.to_i  
      else
        current_item.quantity += 1
      end  
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end
  
  def get_number_items
    self.line_items.count
  end
  
  def remove_item(line_item_id)
    self.line_items.where(id: line_item_id).destroy_all
  end
  
  def total_order
    amount = 0.0
    self.line_items.each do |od|
      amount += od.total_item
    end
    
    return amount
  end
  
  def total_order_sale
    amount = 0.0
    self.line_items.each do |od|
      amount += od.total_item
    end
    
    if voucher.present?
      amount = amount - voucher.price
    end
    
    if coupon.present?
      amount = amount - coupon.price
    end
    
    return amount
  end
  
  def voucher
    return nil if !voucher_code.present?
    
    return Voucher.get_by_code(voucher_code)
  end
  
  def coupon
    return nil if !coupon_code.present?
    
    return Coupon.get_by_code(coupon_code)
  end

end
