class ProductController < ApplicationController
  def category
    @title_head = "Trang chuyên mục"
    @category = Category.find(params[:category_id])
    @products = @category.get_products_for_categories(params).paginate(:page => params[:page], :per_page => 15)
    @areas = Area.get_all_areas
    @manufacturers = Manufacturer.get_all_manufacturers
  end
  
  def product
    @title_head = "Trang sản phẩm"
    @product = Product.find(params[:product_id])
  end
  
  def quick_view
    @product = Product.find(params[:product_id])
    render :layout => false
  end
  
  def comparison
    @title_head = "So sánh sản phẩm"
    @compare.remove_item(params[:line_item_compare_id]) if params[:do] == "remove_item"
  end
  
end
