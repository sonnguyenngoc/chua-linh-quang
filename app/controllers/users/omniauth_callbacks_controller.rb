class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController   
  def facebook
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
    end
  end
  def failure
    redirect_to root_path
  end
  
end