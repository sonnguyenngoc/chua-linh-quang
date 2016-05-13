class CustomFailure < Devise::FailureApp
  def redirect_url
    login_path
  end

  def respond
    if http_auth?
      http_auth
    else
      flash[:error] = "Đăng nhập thất bại!"
      redirect
    end
  end
end