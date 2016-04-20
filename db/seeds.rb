# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#.....
User.create(:email => "admin@hoangkhang.com.vn", :password => "aA456321@", :password_confirmation => "aA456321@")
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