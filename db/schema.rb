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

ActiveRecord::Schema[7.1].define(version: 2024_11_10_123038) do
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

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "server_id"
    t.integer "events_id"
    t.index ["events_id"], name: "index_channels_on_events_id"
    t.index ["server_id"], name: "index_channels_on_server_id"
  end

  create_table "commands", force: :cascade do |t|
    t.integer "server_id", null: false
    t.string "target"
    t.string "command"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "length"
    t.string "logs"
    t.string "response"
    t.index ["server_id"], name: "index_commands_on_server_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "videos_id"
    t.datetime "start_time", precision: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_type", default: 0
    t.index ["videos_id"], name: "index_events_on_videos_id"
  end

  create_table "licences", force: :cascade do |t|
    t.string "key"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "servers", default: []
  end

  create_table "schedules", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "channel_id"
    t.index ["channel_id"], name: "index_schedules_on_channel_id"
    t.index ["event_id"], name: "index_schedules_on_event_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name"
    t.integer "cpu"
    t.integer "total_memory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "licence_id"
    t.index ["licence_id"], name: "index_servers_on_licence_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "length"
    t.integer "stored_in_id"
    t.index ["stored_in_id"], name: "index_videos_on_stored_in_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "channels", "events", column: "events_id"
  add_foreign_key "channels", "servers"
  add_foreign_key "commands", "servers"
  add_foreign_key "events", "videos", column: "videos_id"
  add_foreign_key "schedules", "channels"
  add_foreign_key "schedules", "events"
  add_foreign_key "servers", "licences"
  add_foreign_key "videos", "servers", column: "stored_in_id"
end
