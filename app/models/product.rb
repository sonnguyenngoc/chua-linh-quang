class Product < ActiveRecord::Base
  validates :name, :price, :quantity, :unit, :manufacturer_id, :short_description, presence: true
  
  belongs_to :category
  has_many :categories_products
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :areas
  belongs_to :manufacturer
  has_many :product_images
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |a| a[:image_url].blank? && a[:id].blank? }, :allow_destroy => true

  def self.get_products_for_manufacturer(params)
    records = self.where(manufacturer_id: params[:manufacturer_id])
    
    return records
  end
end
