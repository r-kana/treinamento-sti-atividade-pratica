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

ActiveRecord::Schema.define(version: 2022_05_06_062335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colleges", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.string "city"
    t.string "neighborhood"
    t.string "cep", limit: 9
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ride_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ride_id"], name: "index_reservations_on_ride_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "rides", force: :cascade do |t|
    t.text "observation"
    t.string "destination_neighborhood"
    t.string "departure_neighborhood"
    t.integer "seats", default: 0
    t.integer "number_of_passagers", default: 0
    t.date "date", null: false
    t.time "time", null: false
    t.boolean "to_college", null: false
    t.boolean "full", default: false, null: false
    t.boolean "active", default: true, null: false
    t.float "price", default: 0.0
    t.bigint "college_id", null: false
    t.bigint "driver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["college_id"], name: "index_rides_on_college_id"
    t.index ["driver_id"], name: "index_rides_on_driver_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "iduff"
    t.boolean "admin"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "waypoints", force: :cascade do |t|
    t.string "address", null: false
    t.string "city", null: false
    t.string "neighborhood", null: false
    t.integer "order", default: 0, null: false
    t.boolean "is_college", null: false
    t.integer "kind", limit: 2, null: false
    t.bigint "ride_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ride_id"], name: "index_waypoints_on_ride_id"
  end

  add_foreign_key "reservations", "rides"
  add_foreign_key "reservations", "users"
  add_foreign_key "rides", "users", column: "driver_id"
end
