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

ActiveRecord::Schema.define(version: 20160112054455) do

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
    t.string   "redemption",     limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "jbz_skus", ["product_id"], name: "index_jbz_skus_on_product_id", using: :btree
  add_index "jbz_skus", ["ref"], name: "index_jbz_skus_on_ref", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "jbz_sku_id", limit: 4
    t.integer  "cart_id",    limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "quantity",   limit: 4, default: 1
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["jbz_sku_id"], name: "index_line_items_on_jbz_sku_id", using: :btree

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

end
