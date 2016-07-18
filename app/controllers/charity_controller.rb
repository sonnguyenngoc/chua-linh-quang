class CharityController < ApplicationController
  def index
    @articles = Article.get_all_charity_blogs.paginate(:page => params[:page], :per_page => 3)
  end
end
