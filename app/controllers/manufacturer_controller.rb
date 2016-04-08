class ManufacturerController < ApplicationController
  def list
    @title_head = "Thương hiệu sản phẩm"
    @manufacturers = Manufacturer.get_all_manufacturers
    @categories = Category.get_all_categories
    @lastest_blog_posts = Article.get_lastest_blog_posts
  end
end
