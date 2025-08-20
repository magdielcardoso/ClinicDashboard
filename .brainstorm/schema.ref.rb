ActiveRecord::Schema.define(version: 1) do
  # Users table: admins and receptionists
  create_table "users", force: :cascade do |t|
    t.string   "name", null: false
    t.string   "email", null: false, index: { unique: true }
    t.string   "role", null: false, default: "attendant" # enum: admin, attendant
    t.string   "encrypted_password", null: false
    t.timestamps
  end

  # Clients table: patients of the clinic
  create_table "clients", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name", null: false
    t.string   "email", index: { unique: true }
    t.string   "phone"
    t.timestamps
  end

  # Procedures table: services offered by the clinic
  create_table "procedures", force: :cascade do |t|
    t.string   "name", null: false
    t.text     "description"
    t.decimal  "price", precision: 10, scale: 2, null: false
    t.timestamps
  end

  # Appointments table: scheduling data
  create_table "appointments", force: :cascade do |t|
    t.references "client", null: false, foreign_key: true
    t.references "procedure", null: false, foreign_key: true
    t.references "user", null: false, foreign_key: true # who created the appointment
    t.datetime   "scheduled_at", null: false, index: true
    t.string     "status", null: false, default: "scheduled" # enum: scheduled, completed, canceled
    t.text       "notes"
    t.timestamps
  end
end
