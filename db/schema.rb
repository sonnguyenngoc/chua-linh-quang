# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160815011801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "level"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "parent_id"
    t.integer  "areatype_id"
    t.integer  "display_order"
  end

  create_table "areas_articles", force: :cascade do |t|
    t.integer  "area_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "areas_products", force: :cascade do |t|
    t.integer  "area_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "level"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.string   "style"
    t.integer  "position",         default: 1
    t.integer  "user_id"
  end

  create_table "article_categories_articles", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "article_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "image_url"
    t.string   "title"
    t.text     "content"
    t.string   "tags"
    t.integer  "article_category_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "code_status_id"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.boolean  "is_show",              default: false
    t.string   "page_layout"
    t.integer  "user_id"
    t.boolean  "approved",             default: false
    t.string   "image_url_full_width"
    t.boolean  "is_mine",              default: false
  end

  create_table "articles_products", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banners", force: :cascade do |t|
    t.string   "image_url"
    t.string   "title"
    t.string   "banner_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "voucher_code"
    t.string   "coupon_code"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "level"
    t.text     "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "ordered"
    t.string   "meta_keywords"
    t.text     "meta_description"
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "code_statuses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "comment_articles", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "parent_id",  default: -1
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.text     "content"
    t.integer  "star"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "image_url"
    t.string   "name"
    t.string   "head_office_address"
    t.string   "certificate_no"
    t.datetime "date_of_issue"
    t.string   "sales_office_address"
    t.string   "phone"
    t.string   "hotline"
    t.string   "email"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "head_area_id"
    t.integer  "branch_area_id"
    t.string   "type_company"
  end

  create_table "compares", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "phone"
    t.string   "unit"
    t.string   "address"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "from_date"
    t.datetime "to_date"
    t.text     "description"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "price"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "company"
    t.string   "address"
    t.string   "city"
    t.integer  "zip_code"
    t.string   "country"
    t.string   "province"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.integer  "area_id"
  end

  create_table "delivery_methods", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "email"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "gallery_image_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "image_url"
  end

  create_table "gallery_images", force: :cascade do |t|
    t.string   "image_url"
    t.integer  "gallery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_item_compares", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "compare_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "line_item_compares", ["compare_id"], name: "index_line_item_compares_on_compare_id", using: :btree
  add_index "line_item_compares", ["product_id"], name: "index_line_item_compares_on_product_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quantity",   default: 1
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "manufacturers", force: :cascade do |t|
    t.string   "image_url"
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "seen"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "newsletters", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "status",     default: true
    t.integer  "user_id"
  end

  create_table "options", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "code"
    t.string   "tag"
    t.text     "value"
    t.text     "note"
    t.string   "title"
    t.boolean  "accept_email", default: false
  end

  create_table "order_deliveries", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "address"
    t.string   "city"
    t.integer  "zip_code"
    t.string   "country"
    t.string   "province"
    t.integer  "delivery_method_id"
    t.integer  "payment_method_id"
    t.text     "message"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "order_id"
    t.string   "email"
    t.string   "phone"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "product_name"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id"
    t.string   "status",             default: "Pending"
    t.boolean  "different_delivery", default: false
    t.string   "voucher_code"
    t.decimal  "voucher_price"
    t.string   "coupon_code"
    t.decimal  "coupon_price"
  end

  create_table "parent_article_categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "article_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "parent_categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image_url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "is_main",    default: "False"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "quantity"
    t.string   "unit"
    t.decimal  "price"
    t.text     "short_description"
    t.text     "description"
    t.integer  "manufacturer_id"
    t.integer  "product_image_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "tags"
    t.text     "status"
    t.decimal  "old_price"
    t.decimal  "discount_percent"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.boolean  "is_show",           default: false
    t.integer  "stock",             default: 1
    t.boolean  "approved",          default: false
    t.integer  "user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slideshows", force: :cascade do |t|
    t.string   "image_url"
    t.string   "title_1"
    t.string   "title_2"
    t.string   "name_button"
    t.string   "link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "color_1"
    t.string   "color_2"
    t.string   "style"
  end

  create_table "testimonials", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "email"
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.string   "name"
    t.text     "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip"
    t.text     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "fax"
    t.string   "company"
    t.string   "address_1"
    t.string   "address_2"
    t.integer  "zip_code"
    t.string   "country"
    t.string   "province"
    t.string   "city"
    t.string   "provider"
    t.string   "uid"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "last_seen"
    t.boolean  "is_admin",               default: false
    t.integer  "area_id"
    t.string   "role"
    t.integer  "user_group_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vouchers", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "from_date"
    t.datetime "to_date"
    t.text     "description"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "price"
  end

  create_table "wish_lists", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "line_item_compares", "compares"
  add_foreign_key "line_item_compares", "products"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "products"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end
