class OrderDelivery < ActiveRecord::Base
  belongs_to :order
  belongs_to :delivery_method
  belongs_to :payment_method
  
  def name
    first_name + " " + last_name
  end
  def display_address
    str = []
    str << address if address.present?
    str << city if city.present?
    str << province if province.present?
    str << country if country.present?
    str << zip_code if zip_code.present?
    
    return str.join(", ")
  end

end
