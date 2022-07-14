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

ActiveRecord::Schema[7.0].define(version: 2022_07_14_110245) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "run_slices", force: :cascade do |t|
    t.integer "run_summary_id", null: false
    t.string "nominal_distance"
    t.integer "start_index", null: false
    t.integer "end_index", null: false
    t.integer "start_time"
    t.integer "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_summary_id"], name: "index_run_slices_on_run_summary_id"
  end

  create_table "run_summaries", force: :cascade do |t|
    t.uuid "run_id", null: false
    t.decimal "total_time", null: false
    t.decimal "total_distance", null: false
    t.datetime "start_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "raw_data_uri"
    t.string "interval_data_uri"
  end

  create_table "runs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time", null: false
  end

end
