class CategoryController < ApplicationController
  def index
    @category = ArticleCategory.find(params[:category_id])
    @posts = @category.get_posts_for_categories(params).paginate(:page => params[:page], :per_page => 12)
  end
end
