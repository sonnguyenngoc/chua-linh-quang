class Customer < ActiveRecord::Base
  belongs_to :order
  
  def name
    first_name + " " + last_name
  end
end
