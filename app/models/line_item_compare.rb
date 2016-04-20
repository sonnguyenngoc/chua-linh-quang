class LineItemCompare < ActiveRecord::Base
  belongs_to :product
  belongs_to :compare
  
  def self.get_all_items
    self.all.order("created_at DESC").first(4)
  end
end
