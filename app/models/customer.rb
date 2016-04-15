class Customer < ActiveRecord::Base
  belongs_to :order
end
