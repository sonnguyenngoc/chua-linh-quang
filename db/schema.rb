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

ActiveRecord::Schema.define(version: 20160521024747) do

  create_table "areas", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "level",         limit: 4
    t.text     "description",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "parent_id",     limit: 4
    t.integer  "areatype_id",   limit: 4
    t.integer  "display_order", limit: 4
  end

  create_table "areas_products", force: :cascade do |t|
    t.integer  "area_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "article_categories", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.text     "description",      limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "level",            limit: 4
    t.string   "meta_keywords",    limit: 255
    t.text     "meta_description", limit: 65535
  end

  create_table "article_categories_articles", force: :cascade do |t|
    t.integer  "article_id",          limit: 4
    t.integer  "article_category_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "image_url",           limit: 255
    t.string   "title",               limit: 255
    t.text     "content",             limit: 65535
    t.string   "tags",                limit: 255
    t.integer  "article_category_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "code_status_id",      limit: 4
    t.string   "meta_keywords",       limit: 255
    t.text     "meta_description",    limit: 65535
  end

  create_table "articles_products", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "voucher_code", limit: 255
    t.string   "coupon_code",  limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "level",            limit: 4
    t.text     "description",      limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "ordered",          limit: 4
    t.string   "meta_keywords",    limit: 255
    t.text     "meta_description", limit: 65535
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "code_statuses", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "comment_articles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "article_id", limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "parent_id",  limit: 4,     default: -1
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "name",       limit: 255
    t.text     "content",    limit: 65535
    t.integer  "star",       limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "image_url",            limit: 255
    t.string   "name",                 limit: 255
    t.string   "head_office_address",  limit: 255
    t.string   "certificate_no",       limit: 255
    t.datetime "date_of_issue"
    t.string   "sales_office_address", limit: 255
    t.string   "phone",                limit: 255
    t.string   "hotline",              limit: 255
    t.string   "email",                limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "head_area_id",         limit: 4
    t.integer  "branch_area_id",       limit: 4
    t.string   "type_company",         limit: 255
  end

  create_table "compares", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.datetime "from_date"
    t.datetime "to_date"
    t.text     "description", limit: 65535
    t.integer  "quantity",    limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.decimal  "price",                     precision: 10
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.string   "company",    limit: 255
    t.string   "address",    limit: 255
    t.string   "city",       limit: 255
    t.integer  "zip_code",   limit: 4
    t.string   "country",    limit: 255
    t.string   "province",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "order_id",   limit: 4
  end

  create_table "delivery_methods", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "line_item_compares", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "compare_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "line_item_compares", ["compare_id"], name: "index_line_item_compares_on_compare_id", using: :btree
  add_index "line_item_compares", ["product_id"], name: "index_line_item_compares_on_product_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "cart_id",    limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "quantity",   limit: 4, default: 1
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "manufacturers", force: :cascade do |t|
    t.string   "image_url",   limit: 255
    t.string   "name",        limit: 255
    t.string   "address",     limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body",            limit: 65535
    t.integer  "conversation_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "seen"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "newsletters", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "status",                 default: true
  end

  create_table "options", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "code",         limit: 255
    t.string   "tag",          limit: 255
    t.text     "value",        limit: 65535
    t.text     "note",         limit: 65535
    t.string   "title",        limit: 255
    t.boolean  "accept_email",               default: false
  end

  create_table "order_deliveries", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "company",            limit: 255
    t.string   "address",            limit: 255
    t.string   "city",               limit: 255
    t.integer  "zip_code",           limit: 4
    t.string   "country",            limit: 255
    t.string   "province",           limit: 255
    t.integer  "delivery_method_id", limit: 4
    t.integer  "payment_method_id",  limit: 4
    t.text     "message",            limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "order_id",           limit: 4
    t.string   "email",              limit: 255
    t.string   "phone",              limit: 255
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id",     limit: 4
    t.integer  "product_id",   limit: 4
    t.integer  "quantity",     limit: 4
    t.decimal  "price",                    precision: 10
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "product_name", limit: 255
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.integer  "user_id",            limit: 4
    t.string   "status",             limit: 255,                default: "Pending"
    t.boolean  "different_delivery",                            default: false
    t.string   "voucher_code",       limit: 255
    t.decimal  "voucher_price",                  precision: 10
    t.string   "coupon_code",        limit: 255
    t.decimal  "coupon_price",                   precision: 10
  end

  create_table "parent_article_categories", force: :cascade do |t|
    t.integer  "parent_id",           limit: 4
    t.integer  "article_category_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "parent_categories", force: :cascade do |t|
    t.integer  "parent_id",   limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "image_url",  limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "is_main",    limit: 255, default: "False"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "code",              limit: 255
    t.decimal  "quantity",                        precision: 10
    t.string   "unit",              limit: 255
    t.decimal  "price",                           precision: 10
    t.text     "short_description", limit: 65535
    t.text     "description",       limit: 65535
    t.integer  "manufacturer_id",   limit: 4
    t.integer  "product_image_id",  limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "tags",              limit: 255
    t.text     "status",            limit: 65535
    t.decimal  "old_price",                       precision: 10
    t.decimal  "discount_percent",                precision: 10
    t.string   "meta_keywords",     limit: 255
    t.text     "meta_description",  limit: 65535
  end

  create_table "questions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "product_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "slideshows", force: :cascade do |t|
    t.string   "image_url",   limit: 255
    t.string   "title_1",     limit: 255
    t.string   "title_2",     limit: 255
    t.string   "name_button", limit: 255
    t.string   "link",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "color_1",     limit: 255
    t.string   "color_2",     limit: 255
    t.string   "style",       limit: 255
  end

  create_table "testimonials", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "city",       limit: 255
    t.string   "email",      limit: 255
    t.string   "content",    limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip",     limit: 65535
    t.text     "last_sign_in_ip",        limit: 65535
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "phone",                  limit: 255
    t.integer  "fax",                    limit: 4
    t.string   "company",                limit: 255
    t.string   "address_1",              limit: 255
    t.string   "address_2",              limit: 255
    t.integer  "zip_code",               limit: 4
    t.string   "country",                limit: 255
    t.string   "province",               limit: 255
    t.string   "city",                   limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "oauth_token",            limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "last_seen"
    t.boolean  "is_admin",                             default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vouchers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.datetime "from_date"
    t.datetime "to_date"
    t.text     "description", limit: 65535
    t.integer  "quantity",    limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.decimal  "price",                     precision: 10
  end

  create_table "wish_lists", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_foreign_key "line_item_compares", "compares"
  add_foreign_key "line_item_compares", "products"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "products"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end
