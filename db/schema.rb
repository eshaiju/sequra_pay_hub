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

ActiveRecord::Schema[7.0].define(version: 2023_11_09_145224) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "disbursement_frequency", ["daily", "weekly"]

  create_table "disbursements", force: :cascade do |t|
    t.bigint "merchant_id", null: false
    t.string "reference", null: false
    t.date "disbursement_date", null: false
    t.decimal "total_amount", precision: 8, scale: 2, null: false
    t.decimal "total_fee", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_disbursements_on_merchant_id"
    t.index ["reference"], name: "index_disbursements_on_reference", unique: true
  end

  create_table "merchants", force: :cascade do |t|
    t.string "reference"
    t.string "email"
    t.date "live_on"
    t.decimal "minimum_monthly_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "disbursement_frequency", default: "daily", null: false, enum_type: "disbursement_frequency"
    t.index ["email"], name: "index_merchants_on_email", unique: true
    t.index ["reference"], name: "index_merchants_on_reference", unique: true
  end

  create_table "monthly_fees", force: :cascade do |t|
    t.bigint "merchant_id", null: false
    t.decimal "total_commissions", precision: 8, scale: 2, null: false
    t.decimal "monthly_fee", precision: 8, scale: 2, null: false
    t.date "month", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_monthly_fees_on_merchant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "merchant_id", null: false
    t.decimal "amount"
    t.date "order_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "disbursement_reference"
    t.bigint "disbursement_id"
    t.date "cancelled_at"
    t.index ["cancelled_at"], name: "index_orders_on_cancelled_at"
    t.index ["disbursement_id"], name: "index_orders_on_disbursement_id"
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
  end

  add_foreign_key "disbursements", "merchants"
  add_foreign_key "monthly_fees", "merchants"
  add_foreign_key "orders", "disbursements"
  add_foreign_key "orders", "merchants"
end
