class OrderDelivery < ActiveRecord::Base
  belongs_to :order
  belongs_to :delivery_method
  belongs_to :payment_method
  belongs_to :area, foreign_key: "province"
  
  def name
    first_name.to_s + " " + last_name.to_s
  end
  def display_address
    str = []
    str << address if address.present?
    str << self.area.name if province.present?
    str << "Việt Nam"
    
    return str.join(", ")
  end

end
