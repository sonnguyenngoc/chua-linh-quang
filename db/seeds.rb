# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.destroy_all
#.....
User.create(:email => "admin@hoangkhang.com.vn", :password => "aA456321@", :password_confirmation => "aA456321@", first_name: "Quản trị", last_name: "viên", phone: "01644046123", address_1: "54/3, Tăng NHơn Phú B, Quận 9", is_admin: true)
#.....

DeliveryMethod.delete_all
#.....
DeliveryMethod.create(:title => "Giao hàng tận nhà.", :description => "")
DeliveryMethod.create(:title => "Nhận hàng trực tiếp.", :description => "")
#.....

PaymentMethod.delete_all
#.....
PaymentMethod.create(:title => "Thanh toán trực tiếp", :description => "")
PaymentMethod.create(:title => "Chuyển khoản", :description => "")
PaymentMethod.create(:title => "Trả góp", :description => "")
PaymentMethod.create(:title => "Ghi nợ", :description => "")
#.....

Option.delete_all
#.....
Option.create(:title => "Mua bán, phân phối sản phẩm sạch, món ngon", :tag => "common.page_title", value: "đặc sản vùng miền, dac san vung mien, dacsanvungmien", note: "Mời bạn thưởng thức đặc sản từ khắp mọi miền đất nước với chất lượng được đảm bảo, đặc trưng hương vị vùng miền.")
#.....

UserGroup.create(name: "Thành viên")
UserGroup.create(name: "Quản trị viên")
UserGroup.create(name: "Quản lý cấp cao")