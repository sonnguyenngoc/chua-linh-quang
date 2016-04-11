class ProductController < ApplicationController
  def category
    @title_head = "Trang chuyên mục"
    @category = Category.find(params[:category_id])
    @products = @category.get_products_for_categories(params)
    @areas = Area.get_all_areas
    @manufacturers = Manufacturer.get_all_manufacturers
  end
  
  def product
    @title_head = "Trang sản phẩm"
    @product = Product.find(params[:product_id])
  end
end
