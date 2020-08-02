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

ActiveRecord::Schema.define(version: 2020_08_02_155104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "websites_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "elements", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flows", force: :cascade do |t|
    t.string "name"
    t.datetime "last_update"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "images_count", default: 0
  end

  create_table "flows_images", force: :cascade do |t|
    t.bigint "flow_id"
    t.bigint "image_id"
    t.datetime "created_at", null: false
    t.integer "position"
    t.index ["flow_id", "image_id"], name: "index_flows_images_on_flow_id_and_image_id"
    t.index ["flow_id"], name: "index_flows_images_on_flow_id"
    t.index ["image_id"], name: "index_flows_images_on_image_id"
  end

  create_table "images", force: :cascade do |t|
    t.boolean "mobile_attached"
    t.boolean "desktop_attached"
    t.boolean "tablet_attached"
    t.integer "platforms_count"
    t.integer "elements_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "flows_count", default: 0
    t.integer "patterns_count", default: 0
    t.integer "website_id"
    t.string "name"
    t.integer "position"
    t.datetime "end_date"
    t.integer "next_image_id"
  end

  create_table "images_elements", force: :cascade do |t|
    t.bigint "image_id"
    t.bigint "element_id"
    t.datetime "created_at", null: false
    t.index ["element_id"], name: "index_images_elements_on_element_id"
    t.index ["image_id", "element_id"], name: "index_images_elements_on_image_id_and_element_id"
    t.index ["image_id"], name: "index_images_elements_on_image_id"
  end

  create_table "images_patterns", force: :cascade do |t|
    t.bigint "image_id"
    t.bigint "pattern_id"
    t.datetime "created_at", null: false
    t.index ["image_id", "pattern_id"], name: "index_images_patterns_on_image_id_and_pattern_id"
    t.index ["image_id"], name: "index_images_patterns_on_image_id"
    t.index ["pattern_id"], name: "index_images_patterns_on_pattern_id"
  end

  create_table "patterns", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "websites", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_websites_on_category_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
