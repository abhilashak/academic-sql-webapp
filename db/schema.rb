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

ActiveRecord::Schema[8.0].define(version: 2025_07_09_155152) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "category_enum", ["men", "women", "kids", "infants"]
  create_enum "gender_enum", ["male", "female", "not-specified"]

  create_table "courses", force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.text "description"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

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

  create_table "schools", force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.bigint "school_id", null: false
    t.date "enrolment_date", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["course_id"], name: "idx_students_course_id"
    t.index ["school_id"], name: "idx_students_school_id"
    t.unique_constraint ["user_id"], name: "unique_students_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 150, null: false
    t.string "phone_number", limit: 20
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "first_name", limit: 100, null: false
    t.string "middle_name", limit: 100
    t.string "last_name", limit: 100, null: false
    t.enum "gender", enum_type: "gender_enum"
    t.date "date_of_birth"
    t.index ["email"], name: "idx_users_email"
  end

  add_foreign_key "orders", "products", name: "fk_orders_product_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "orders", "users", name: "fk_orders_user_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "students", "courses", name: "fk_students_course_id"
  add_foreign_key "students", "schools", name: "fk_students_school_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "students", "users", name: "fk_students_user_id", on_update: :cascade, on_delete: :cascade
end
