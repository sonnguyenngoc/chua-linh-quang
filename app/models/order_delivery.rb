class OrderDelivery < ActiveRecord::Base
  belongs_to :order
  belongs_to :delivery_method
  belongs_to :payment_method
end
