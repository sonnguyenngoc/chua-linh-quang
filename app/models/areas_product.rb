class AreasProduct < ActiveRecord::Base
  belongs_to :area
  belongs_to :product
end
