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

ActiveRecord::Schema.define(version: 20170504151159) do

  create_table "location_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "tracking_id", null: false
    t.decimal "lat", precision: 10, null: false
    t.decimal "lon", precision: 10, null: false
    t.decimal "accuracy", precision: 10
    t.datetime "created_at"
    t.index ["created_at"], name: "index_location_logs_on_created_at"
    t.index ["tracking_id"], name: "index_location_logs_on_tracking_id"
  end

  create_table "observations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "tracking_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tracking_id"], name: "index_observations_on_tracking_id"
    t.index ["updated_at"], name: "index_observations_on_updated_at"
    t.index ["user_id"], name: "index_observations_on_user_id"
  end

  create_table "trackings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code", limit: 64, null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_trackings_on_owner_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "gcm_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "location_logs", "trackings"
  add_foreign_key "observations", "trackings"
  add_foreign_key "observations", "users"
  add_foreign_key "trackings", "users", column: "owner_id"
end
