class ManufacturerController < ApplicationController
  def list
    @title_head = "Thương hiệu sản phẩm"
    @manufacturers = Manufacturer.get_all_manufacturers.paginate(:page => params[:page], :per_page => 12)
  end
  
  def products
    @title_head = "Sản phẩm thuộc thương hiệu"
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    params[:number] = 15 if !params[:number].present?
    @products = Product.get_products_for_manufacturer(params).paginate(:page => params[:page], :per_page => params[:number])
  end
end
