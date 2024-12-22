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

ActiveRecord::Schema[7.0].define(version: 2023_11_27_171919) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "doctor_id"
    t.bigint "patient_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "working_hour_id"
    t.datetime "time"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["working_hour_id"], name: "index_appointments_on_working_hour_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "photo"
    t.string "phone_number"
    t.string "position"
    t.integer "experience"
    t.integer "satisfied_patients_count", default: 0
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "photo"
    t.datetime "birthday"
    t.string "residence"
    t.string "phone_number"
    t.integer "gender"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.integer "score"
    t.text "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_ratings_on_doctor_id"
    t.index ["patient_id"], name: "index_ratings_on_patient_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "doctor_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_schedules_on_doctor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "working_days", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 0
    t.integer "priority"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_working_days_on_schedule_id"
  end

  create_table "working_hours", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "working_day_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hour_gone", default: false
    t.datetime "hour"
    t.index ["working_day_id"], name: "index_working_hours_on_working_day_id"
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "doctors", "users"
  add_foreign_key "patients", "users"
  add_foreign_key "ratings", "doctors"
  add_foreign_key "ratings", "patients"
  add_foreign_key "schedules", "doctors"
  add_foreign_key "working_days", "schedules"
  add_foreign_key "working_hours", "working_days"
end
