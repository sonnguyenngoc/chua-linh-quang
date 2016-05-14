class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["ominauth.auth"])
    session[:user_id] = user.id
    redirect_to my_account_path
  end

  def destroy
    session[:user_id] = nil
    session[:omniauth] = nil
    redirect_to logout_path
  end
end
