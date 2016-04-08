class ProductController < ApplicationController
  def category
    @title_head = "Trang chuyên mục"
    @categories = Category.get_all_categories
    @lastest_blog_posts = Article.get_lastest_blog_posts
    @category = Category.find(params[:category_id])
    @products = @category.get_products_for_categories(params)
    @areas = Area.get_all_areas
    @manufacturers = Manufacturer.all
  end
end
