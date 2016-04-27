class ManufacturerController < ApplicationController
  def list
    @title_head = "Thương hiệu sản phẩm"
    @manufacturers = Manufacturer.get_all_manufacturers
  end
  
  def products
    @title_head = "Sản phẩm thuộc thương hiệu"
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @products = Product.get_products_for_manufacturer(params).paginate(:page => params[:page], :per_page => 15)
  end
end
