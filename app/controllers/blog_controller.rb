class BlogController < ApplicationController
  def index
    @title_head = "Danh sách bài viết"
    @lastest_blog_posts = Article.get_lastest_blog_posts
    @blogs = Article.get_all_blogs.paginate(:page => params[:page], :per_page => 3)
  end
  def show
    @title_head = "Chi tiết bài viết"
    @lastest_blog_posts = Article.get_lastest_blog_posts
    @blog = Article.find(params[:blog_id])
  end
end
