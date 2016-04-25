class Customer < ActiveRecord::Base
  belongs_to :order
  
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
    #address.to_s + ", " + city.to_s + ", " + province.to_s + ", " + country.to_s + ", " + zip_code.to_s
    
    return str.join(", ")
  end
end
