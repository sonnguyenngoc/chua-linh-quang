class AccountController < ApplicationController
  def login
    @title_head = "Đăng nhập"
    redirect_to my_account_path if current_user.present?
  end
  
  def logout
    @title_head = "Đăng xuất"
    redirect_to my_account_path if current_user.present?
  end
  
  def register
    @title_head = "Đăng ký"
    redirect_to my_account_path if current_user.present?
  end
  
  def my_account
  	@title_head = "Tài khoản của tôi"
  	redirect_to login_path if !current_user.present?
  end
  
  def forgotten
		@title_head = "Quên mật khẩu"
		redirect_to my_account_path if current_user.present?
  end
  
  def edit
    @title_head = "Chỉnh sửa tài khoản"
    redirect_to login_path if !current_user.present?
  end
  
  def password
    @title_head = "Thay đổi mật khẩu"
    redirect_to login_path if !current_user.present?
  end
  
  def address
    @title_head = "Địa chỉ đặt hàng"
    redirect_to login_path if !current_user.present?
  end
  
  def address_edit
    @title_head = "Thay đổi địa chỉ đặt hàng"
    redirect_to login_path if !current_user.present?
  end
  
  def order
    @title_head = "Lịch sử đặt hàng"
    redirect_to login_path if !current_user.present?
  end
  
  def order_info
		@order = Order.find(params[:order_id])
    @title_head = "Chi tiết đơn hàng"
    redirect_to login_path if !current_user.present?
  end
  
  def wishlist
    @title_head = "Sản phẩm yêu thích"
    @products = current_user.wish_lists.paginate(:page => params[:page], :per_page => 6)
    redirect_to login_path if !current_user.present?
  end
  
  def newsletter
		@title_head = "Đăng ký nhận tin mới"
		redirect_to login_path if !current_user.present?
  end
  
  def no_singed
		render :layout => false
  end
  
  def voucher
		@title_head = "Phiếu quà tặng"
		redirect_to login_path if !current_user.present?	
  end
end
