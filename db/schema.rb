# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_11_223126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin", default: false, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["uid", "provider"], name: "index_accounts_on_uid_and_provider", unique: true
  end

  create_table "offers", force: :cascade do |t|
    t.string "advertiser_name", null: false
    t.string "url", null: false
    t.text "description", null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at"
    t.boolean "premium", default: false, null: false
    t.boolean "available", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["advertiser_name"], name: "index_offers_on_advertiser_name", unique: true
  end

end
