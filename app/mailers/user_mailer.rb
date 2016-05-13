class UserMailer < ApplicationMailer
  default from: "soft.support@hoangkhang.com.vn"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Cập nhật lại mật khẩu"
  end
end
