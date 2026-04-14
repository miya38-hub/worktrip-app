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

ActiveRecord::Schema[8.0].define(version: 2026_04_14_123858) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email_address"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "spot_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_comments_on_spot_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "spot_id", null: false
    t.integer "rating"
    t.integer "wifi_rating"
    t.integer "power_rating"
    t.integer "quietness_rating"
    t.integer "workability_rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_reviews_on_spot_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.integer "category"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.boolean "wifi"
    t.boolean "power_supply"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "email"
    t.text "introduction"
    t.boolean "is_active", default: true
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "spots"
  add_foreign_key "comments", "users"
  add_foreign_key "reviews", "spots"
  add_foreign_key "reviews", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "spots", "users"
end
