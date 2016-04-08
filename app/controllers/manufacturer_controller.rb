class ManufacturerController < ApplicationController
  def list
    @title_head = "Thương hiệu sản phẩm"
    @manufacturers = Manufacturer.get_all_manufacturers
  end
end
