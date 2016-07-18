class BuddhistFamilyController < ApplicationController
  def index
    @articles = Article.get_all_buddhist_family_blogs.paginate(:page => params[:page], :per_page => 3)
  end
end
