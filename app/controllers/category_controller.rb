class CategoryController < ApplicationController
  def index
    @category = ArticleCategory.find(params[:category_id])
    @posts = @category.get_posts_for_categories(params).paginate(:page => params[:page], :per_page => 14)
  end
  
  def hot_news
    @posts = Article.get_all_hot_news.paginate(:page => params[:page], :per_page => 14)
  end
  
  def posts_search
    @posts = Article.search(params).paginate(:page => params[:page], :per_page => 14)
  end
end
