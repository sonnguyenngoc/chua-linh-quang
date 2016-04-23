# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
#.....
User.create(:email => "admin@hoangkhang.com.vn", :password => "aA456321@", :password_confirmation => "aA456321@", first_name: "Quản trị", last_name: "viên", phone: "01644046123", address_1: "54/3, Tăng NHơn Phú B, Quận 9")
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

Article.delete_all
#.....
Article.create(:title => "Chính sách giao hàng", :content => "<p>Nội dung ...</p>", :tags => "delivery information", code: "delivery_information")
Article.create(:title => "Chính sách bảo mật", :content => "<p>Nội dung ...</p>", :tags => "privacy policy", code: "privacy_policy")
Article.create(:title => "Điều khoản & điều kiện", :content => "<p>Nội dung ...</p>", :tags => "terms conditions", code: "terms_conditions")
Article.create(:title => "Sản phẩm đạt chất lượng tốt nhất", :content => "<p>Nội dung ...</p>", code: "the_highest_product_quality")
Article.create(:title => "Giao hàng nhanh & miễn phí", :content => "<p>Nội dung ...</p>", code: "fast_free_delivery")
Article.create(:title => "Đặt hàng nhanh chóng & bảo mật thông tin", :content => "<p>Nội dung ...</p>", code: "safe_secure_order")
Article.create(:title => "Hoàn tiền 100% nếu sản phẩm không đạt yêu cầu", :content => "<p>Nội dung ...</p>", code: "money_back")
#.....