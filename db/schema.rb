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

ActiveRecord::Schema[7.0].define(version: 2024_11_02_083325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "reports", force: :cascade do |t|
    t.text "content"
    t.boolean "is_scam", default: false
    t.boolean "analyzed", default: false
    t.text "recommendations"
    t.text "reasons"
    t.string "url"
    t.string "domain"
    t.string "entity"
    t.string "subject"
    t.text "keywords", default: [], array: true
    t.text "keywords_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keywords"], name: "index_reports_on_keywords", using: :gin
    t.index ["keywords_text"], name: "index_reports_on_keywords_text", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "full_name", null: false
    t.string "phone", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "status", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
