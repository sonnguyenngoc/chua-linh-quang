class HomeController < ApplicationController
  def index
    @lastest_blog_posts = Article.get_lastest_blog_posts
    @option = Option.get("common.page_title")
    @title_head = @option.title
    @META_KEYWORDS = @option.value
    @META_DESCRIPTION = @option.note
  end
  
  def countdown
    render layout: nil
  end
  
  def change_current_area
    area = Area.where(id: params[:area_id]).first
    session[:current_area_id] = area.nil? ? nil : area.id
    
    redirect_to :back
  end
end
