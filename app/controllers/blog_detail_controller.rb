class BlogDetailController < ApplicationController
  def index
    @blog_detail = Article.find(params[:blog_id])
  end
end
