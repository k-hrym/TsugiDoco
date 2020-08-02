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

ActiveRecord::Schema.define(version: 2020_08_02_142253) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_valid", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_likes_on_route_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "place_images", force: :cascade do |t|
    t.integer "place_id", null: false
    t.integer "user_id", null: false
    t.string "image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_place_images_on_place_id"
    t.index ["user_id"], name: "index_place_images_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.integer "genre_id"
    t.string "name", null: false
    t.text "explanation"
    t.string "postcode"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "access"
    t.string "tel"
    t.string "url"
    t.string "hours"
    t.string "price"
    t.string "holiday"
    t.boolean "is_closed", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_places_on_genre_id"
  end

  create_table "relations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_relations_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relations_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relations_on_user_id"
  end

  create_table "routes", force: :cascade do |t|
    t.integer "user_id"
    t.string "title", null: false
    t.text "explanation"
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_routes_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.integer "route_id"
    t.integer "place_id"
    t.integer "order", default: 1, null: false
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_spots_on_place_id"
    t.index ["route_id"], name: "index_spots_on_route_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "place_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.text "profile"
    t.date "birth"
    t.string "profile_image_id"
    t.integer "sex"
    t.boolean "is_valid", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wents", force: :cascade do |t|
    t.integer "user_id"
    t.integer "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_wents_on_place_id"
    t.index ["user_id", "place_id"], name: "index_wents_on_user_id_and_place_id", unique: true
    t.index ["user_id"], name: "index_wents_on_user_id"
  end

  create_table "wishes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_wishes_on_place_id"
    t.index ["user_id", "place_id"], name: "index_wishes_on_user_id_and_place_id", unique: true
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

end
