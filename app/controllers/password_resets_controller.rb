class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to login_path, :notice => "Vui lòng kiểm tra email đăng ký tài khoản để xác nhận yêu cầu."
  end
end
