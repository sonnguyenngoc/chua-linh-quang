class HomeController < ApplicationController
  def index
    @title_head = "Trang chủ"
    @lastest_blog_posts = Article.get_lastest_blog_posts
  end
end
