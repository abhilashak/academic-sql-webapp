# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_08_065919) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "category_enum", ["men", "women", "kids", "infants"]

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["product_id"], name: "idx_orders_product_id"
    t.index ["user_id"], name: "idx_orders_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title", limit: 250, null: false
    t.text "description"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.enum "category", null: false, enum_type: "category_enum"
    t.integer "stock_quantity", default: 0, null: false
    t.boolean "active", default: true
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.check_constraint "price > 0::numeric", name: "products_price_check"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 200, null: false
    t.string "email", limit: 150, null: false
    t.string "phone_number", limit: 20
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["email"], name: "idx_users_email"
  end

  add_foreign_key "orders", "products", name: "fk_orders_product_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "orders", "users", name: "fk_orders_user_id", on_update: :cascade, on_delete: :cascade
end
