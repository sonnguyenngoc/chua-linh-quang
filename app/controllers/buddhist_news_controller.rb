class BuddhistNewsController < ApplicationController
  def index
    @articles = Article.get_all_buddhist_news.paginate(:page => params[:page], :per_page => 3)
  end
end
