class AccountController < ApplicationController
  def login
    @title_head = "Đăng nhập"
  end
  
  def logout
    @title_head = "Đăng xuất"
  end
  
  def register
    @title_head = "Đăng ký"
  end
end
