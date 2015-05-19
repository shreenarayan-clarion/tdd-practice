# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140730112523) do

  create_table "assets_assignments", force: true do |t|
    t.integer  "asset_id"
    t.integer  "employee_id"
    t.date     "assign_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets_assignments", ["asset_id"], name: "index_assets_assignments_on_asset_id", using: :btree
  add_index "assets_assignments", ["employee_id"], name: "index_assets_assignments_on_employee_id", using: :btree

  create_table "branches", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.text     "projects"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_assignments", force: true do |t|
    t.integer  "device_id"
    t.integer  "employee_id"
    t.date     "assign_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "unassign_date"
  end

  add_index "device_assignments", ["employee_id"], name: "index_device_assignments_on_employee_id", using: :btree

  create_table "device_categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "device_requests", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "device_category_id"
    t.date     "on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier"
  end

  add_index "device_requests", ["device_category_id"], name: "index_device_requests_on_device_category_id", using: :btree

  create_table "device_transactions", force: true do |t|
    t.integer  "vendor_id"
    t.integer  "device_category_id"
    t.float    "vat"
    t.boolean  "accepted"
    t.integer  "invoice_id"
    t.integer  "purchase_order_id"
    t.integer  "quotation_id"
    t.integer  "device_request_id"
    t.string   "request_title"
    t.string   "quotation_title"
    t.string   "purchase_title"
    t.string   "invoice_title"
    t.string   "request_description"
    t.string   "quotation_description"
    t.string   "purchase_description"
    t.string   "invoice_description"
    t.string   "quotation_price"
    t.string   "purchase_price"
    t.string   "invoice_price"
    t.string   "quotation_quantity"
    t.string   "purchase_quantity"
    t.string   "invoice_quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_quantity"
    t.string   "parent_id"
    t.string   "integer"
    t.string   "quotation_notes"
    t.string   "purchase_notes"
    t.string   "invoice_notes"
  end

  add_index "device_transactions", ["device_category_id"], name: "index_device_transactions_on_device_category_id", using: :btree
  add_index "device_transactions", ["device_request_id"], name: "index_device_transactions_on_device_request_id", using: :btree
  add_index "device_transactions", ["vendor_id"], name: "index_device_transactions_on_vendor_id", using: :btree

  create_table "devices", force: true do |t|
    t.integer  "invoice_id"
    t.integer  "vendor_id"
    t.string   "serial_number"
    t.string   "model_number"
    t.string   "ip_address"
    t.string   "status"
    t.datetime "status_date"
    t.integer  "branch_id"
    t.integer  "device_category_id"
    t.integer  "parent_id"
    t.integer  "employee_id"
    t.datetime "deleted_at"
    t.date     "purchase_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "device_identifier"
    t.string   "warranry_year"
    t.string   "warranry_month"
    t.boolean  "lifetime_warranty"
    t.integer  "client_id"
  end

  add_index "devices", ["branch_id"], name: "index_devices_on_branch_id", using: :btree
  add_index "devices", ["employee_id"], name: "index_devices_on_employee_id", using: :btree
  add_index "devices", ["invoice_id"], name: "index_devices_on_invoice_id", using: :btree
  add_index "devices", ["vendor_id"], name: "index_devices_on_vendor_id", using: :btree

  create_table "employees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "employee_number"
    t.string   "designation"
    t.string   "technology"
    t.string   "department"
    t.integer  "branch_id"
    t.datetime "join_date"
    t.datetime "resign_date"
    t.string   "skype_id"
    t.string   "pm_tool_id"
    t.string   "pandian_id"
    t.string   "wiki_id"
    t.string   "sapience_id"
    t.string   "helpdesk_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "employees", ["branch_id"], name: "index_employees_on_branch_id", using: :btree

  create_table "invoices", force: true do |t|
    t.string   "identifier"
    t.integer  "purchase_order_id"
    t.date     "on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["purchase_order_id"], name: "index_invoices_on_purchase_order_id", using: :btree

  create_table "purchase_orders", force: true do |t|
    t.string   "identifier"
    t.integer  "quotation_id"
    t.date     "on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchase_orders", ["quotation_id"], name: "index_purchase_orders_on_quotation_id", using: :btree

  create_table "quotations", force: true do |t|
    t.string   "identifier"
    t.integer  "device_request_id"
    t.date     "on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotations", ["device_request_id"], name: "index_quotations_on_device_request_id", using: :btree

  create_table "software_products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "device_category_id"
    t.string   "version"
    t.boolean  "license"
    t.string   "license_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "purchase_date"
    t.datetime "deleted_at"
  end

  add_index "software_products", ["device_category_id"], name: "index_software_products_on_device_category_id", using: :btree

  create_table "transfers", force: true do |t|
    t.integer  "transferable_id"
    t.string   "transferable_type"
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.date     "transfer_date"
    t.integer  "transferee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.integer  "employee_id"
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["employee_id"], name: "index_users_on_employee_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "contact_number"
    t.string   "fax_number"
    t.string   "mobile_number"
    t.string   "website"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
