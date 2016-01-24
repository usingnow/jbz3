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

ActiveRecord::Schema.define(version: 20160124043701) do

  create_table "adjust_points", force: :cascade do |t|
    t.string   "creditcard_num", limit: 255
    t.text     "request",        limit: 65535
    t.text     "response",       limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "order_id",       limit: 4
    t.integer  "user_id",        limit: 4
  end

  add_index "adjust_points", ["order_id"], name: "index_adjust_points_on_order_id", using: :btree
  add_index "adjust_points", ["user_id"], name: "index_adjust_points_on_user_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jbz_skus", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.decimal  "price",                      precision: 8, scale: 2
    t.decimal  "original_price",             precision: 8, scale: 2
    t.integer  "reward",         limit: 4
    t.integer  "sales_volume",   limit: 4
    t.integer  "product_id",     limit: 4
    t.string   "ref",            limit: 255
    t.integer  "redemption",     limit: 4
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "jbz_skus", ["product_id"], name: "index_jbz_skus_on_product_id", using: :btree
  add_index "jbz_skus", ["ref"], name: "index_jbz_skus_on_ref", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "jbz_sku_id",     limit: 4
    t.integer  "cart_id",        limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "quantity",       limit: 4, default: 1
    t.integer  "order_id",       limit: 4
    t.datetime "redeemed_at"
    t.datetime "written_off_at"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["jbz_sku_id"], name: "index_line_items_on_jbz_sku_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "creditcard_num", limit: 255
    t.string   "email",          limit: 255
    t.string   "cellphone",      limit: 255
    t.string   "address",        limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "user_id",        limit: 4
    t.string   "id_card",        limit: 255
    t.string   "ref",            limit: 255
    t.decimal  "total_amount",               precision: 5,  scale: 2
    t.decimal  "total_reward",               precision: 10
  end

  add_index "orders", ["ref"], name: "index_orders_on_ref", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.string   "image_url",       limit: 255
    t.integer  "insurance_cycle", limit: 4
    t.integer  "age_starts_at",   limit: 4
    t.integer  "age_ends_at",     limit: 4
    t.text     "benifit",         limit: 65535
    t.text     "acknowledgement", limit: 65535
    t.text     "recommendation",  limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "query_points", force: :cascade do |t|
    t.string   "creditcard_num",                         limit: 255
    t.text     "request",                                limit: 65535
    t.text     "response",                               limit: 65535
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "order_id",                               limit: 4
    t.integer  "user_id",                                limit: 4
    t.string   "card_no",                                limit: 255
    t.string   "account_aggregate_integral",             limit: 255
    t.string   "account_aggregate_integral_symbol",      limit: 255
    t.string   "account_convertibility_integral",        limit: 255
    t.string   "account_convertibility_integral_symbol", limit: 255
    t.string   "current_change_integral",                limit: 255
    t.string   "current_change_integral_symbol",         limit: 255
    t.string   "current_new_integral",                   limit: 255
    t.string   "current_new_integral_symbol",            limit: 255
    t.string   "adjust_integral",                        limit: 255
    t.string   "adjust_integral_sign",                   limit: 255
    t.string   "integral_freezing_mark",                 limit: 255
    t.string   "integral_freezing_date",                 limit: 255
    t.string   "name",                                   limit: 255
    t.string   "bonus_point",                            limit: 255
    t.string   "bonus_point_symbol",                     limit: 255
    t.string   "into_integral",                          limit: 255
    t.string   "into_integral_sign",                     limit: 255
    t.string   "roll_out_integral",                      limit: 255
    t.string   "roll_out_integral_symbol",               limit: 255
    t.string   "mileage_convertible_cap",                limit: 255
    t.string   "already_for_mileage",                    limit: 255
    t.string   "available_integral",                     limit: 255
    t.string   "available_integral_symbol",              limit: 255
    t.string   "status",                                 limit: 255
  end

  add_index "query_points", ["order_id"], name: "index_query_points_on_order_id", using: :btree
  add_index "query_points", ["user_id"], name: "index_query_points_on_user_id", using: :btree

  create_table "request_dynamic_passwords", force: :cascade do |t|
    t.string   "creditcard_num", limit: 255
    t.text     "request",        limit: 65535
    t.text     "response",       limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id",        limit: 4
    t.string   "dynamic_key",    limit: 255
  end

  add_index "request_dynamic_passwords", ["user_id"], name: "index_request_dynamic_passwords_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: ""
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "cellphone",              limit: 255
    t.string   "name",                   limit: 255, default: ""
    t.string   "creditcard_num",         limit: 255, default: ""
    t.string   "address",                limit: 255, default: ""
    t.string   "id_card",                limit: 255, default: ""
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "adjust_points", "orders"
  add_foreign_key "adjust_points", "users"
  add_foreign_key "line_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "query_points", "orders"
  add_foreign_key "query_points", "users"
  add_foreign_key "request_dynamic_passwords", "users"
end
