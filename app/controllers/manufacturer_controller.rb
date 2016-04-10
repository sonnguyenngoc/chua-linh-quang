class ManufacturerController < ApplicationController
  def list
    @title_head = "Thương hiệu sản phẩm"
    @manufacturers = Manufacturer.get_all_manufacturers
    @lastest_blog_posts = Article.get_lastest_blog_posts
  end
  
  def products
    @title_head = "Sản phẩm thuộc thương hiệu"
    @lastest_blog_posts = Article.get_lastest_blog_posts
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @products = Product.get_products_for_manufacturer(params)
  end
end
