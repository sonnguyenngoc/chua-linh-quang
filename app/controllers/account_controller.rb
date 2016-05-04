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
  
  def my_account
  	@title_head = "Tài khoản của tôi"
  end
  
  def forgotten
	@title_head = "Quên mật khẩu"
  end
  
  def edit
    @title_head = "Chỉnh sửa tài khoản"
  end
  
  def password
    @title_head = "Thay đổi mật khẩu"
  end
  
  def address
    @title_head = "Địa chỉ đặt hàng"
  end
  
  def address_edit
    @title_head = "Thay đổi địa chỉ đặt hàng"
  end
  
  def order
    @title_head = "Lịch sử đặt hàng"
  end
  
  def order_info
	@order = Order.find(params[:order_id])
    @title_head = "Chi tiết đơn hàng"
  end
  
  def wishlist
    @title_head = "Sản phẩm yêu thích"
  end
  
  def newsletter
	@title_head = "Đăng ký nhận tin mới"
  end
  
  def no_singed
	render :layout => false
  end
  
  def voucher
	@title_head = "Phiếu quà tặng"
  end
end
