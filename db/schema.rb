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

ActiveRecord::Schema.define(version: 2020_07_18_090152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "elements", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "screens", force: :cascade do |t|
    t.boolean "mobile_attached"
    t.boolean "desktop_attached"
    t.boolean "tablet_attached"
    t.integer "platforms_count"
    t.integer "elements_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "screens_elements", force: :cascade do |t|
    t.bigint "screen_id"
    t.bigint "element_id"
    t.datetime "created_at", null: false
    t.index ["element_id"], name: "index_screens_elements_on_element_id"
    t.index ["screen_id", "element_id"], name: "index_screens_elements_on_screen_id_and_element_id"
    t.index ["screen_id"], name: "index_screens_elements_on_screen_id"
  end

end
