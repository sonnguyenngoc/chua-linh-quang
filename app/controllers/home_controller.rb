class HomeController < ApplicationController
  def index
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)      
     if @user.persisted?       
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
    @title_head = "Trang chủ"
    @lastest_blog_posts = Article.get_lastest_blog_posts
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
