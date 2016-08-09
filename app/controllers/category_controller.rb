class CategoryController < ApplicationController
  def index
    @category = ArticleCategory.find(params[:category_id])
  end
end
