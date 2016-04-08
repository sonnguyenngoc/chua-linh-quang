class HomeController < ApplicationController
  def index
    @title_head = "Trang chủ"
    @categories = Category.get_all_categories
    @lastest_blog_posts = Article.get_lastest_blog_posts
  end
end
