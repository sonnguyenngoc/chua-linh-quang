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

UserGroup.create(name: "Thành viên")
UserGroup.create(name: "Quản trị viên")
UserGroup.create(name: "Quản lý cấp cao")