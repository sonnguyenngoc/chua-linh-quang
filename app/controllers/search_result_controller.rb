class SearchResultController < ApplicationController
  def index
    @articles = Article.search(params).paginate(:page => params[:page], :per_page => 9)
  end
end
