class PostDetailController < ApplicationController
  def index
    @post_detail = Article.find(params[:post_id])
    @category = ArticleCategory.find(params[:category_id])
    @related_posts = @category.get_related_posts_for_categories(params)
  end
end
