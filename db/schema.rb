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

ActiveRecord::Schema.define(version: 20170922081852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activation_tokens", force: :cascade do |t|
    t.boolean "redeemed"
    t.datetime "redeemed_on"
    t.string "token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_activation_tokens_on_user_id"
  end

  create_table "admin_settings", force: :cascade do |t|
    t.string "app_title", default: "Rails project", null: false
    t.string "relay_mail_address", default: "foo@bar.org", null: false
    t.string "captcha_system", default: "recaptcha", null: false
    t.integer "user_activation_tokens", default: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
=======
  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "password_reset_digest"
    t.string "email"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "password_reset_timestamp"
    t.boolean "activated", default: false, null: false
  end

  add_foreign_key "activation_tokens", "users"
>>>>>>> fc17e27... Add user authentication and management
end
