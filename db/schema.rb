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

ActiveRecord::Schema.define(version: 2021_06_23_023859) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "boletos", force: :cascade do |t|
    t.integer "bank_code"
    t.integer "agency_number"
    t.integer "bank_account"
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_boletos_on_company_id"
    t.index ["payment_method_id"], name: "index_boletos_on_payment_method_id"
  end

  create_table "charges", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "company_id", null: false
    t.integer "product_id", null: false
    t.string "token"
    t.integer "status", default: 0, null: false
    t.decimal "original_value"
    t.decimal "value_with_discount"
    t.integer "boleto_id"
    t.integer "pix_id"
    t.integer "credit_card_id"
    t.integer "payment_method_id", null: false
    t.integer "credit_card_number"
    t.string "cardholder_name"
    t.integer "cvv"
    t.integer "payment_category", null: false
    t.string "address"
    t.date "effective_payment_date"
    t.date "payment_attempt_date"
    t.string "last_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "billing_due_date"
    t.index ["boleto_id"], name: "index_charges_on_boleto_id"
    t.index ["company_id"], name: "index_charges_on_company_id"
    t.index ["credit_card_id"], name: "index_charges_on_credit_card_id"
    t.index ["end_user_id"], name: "index_charges_on_end_user_id"
    t.index ["payment_method_id"], name: "index_charges_on_payment_method_id"
    t.index ["pix_id"], name: "index_charges_on_pix_id"
    t.index ["product_id"], name: "index_charges_on_product_id"
  end

  create_table "companies", force: :cascade do |t|
    t.integer "cnpj", null: false
    t.string "corporate_name", null: false
    t.string "billing_address", null: false
    t.string "email", null: false
    t.string "email_domain"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
  end

  create_table "company_end_users", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "end_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_end_users_on_company_id"
    t.index ["end_user_id"], name: "index_company_end_users_on_end_user_id"
  end

  create_table "company_payments", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_payments_on_company_id"
    t.index ["payment_method_id"], name: "index_company_payments_on_payment_method_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "token", null: false
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_credit_cards_on_company_id"
    t.index ["payment_method_id"], name: "index_credit_cards_on_payment_method_id"
  end

  create_table "end_users", force: :cascade do |t|
    t.integer "cpf"
    t.string "token"
    t.string "fullname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.float "percentage_fee"
    t.decimal "max_fee"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category", null: false
    t.integer "status", default: 0, null: false
  end

  create_table "payment_receipts", force: :cascade do |t|
    t.string "effective_payment_date"
    t.string "billing_due_date"
    t.string "authorization_code"
    t.integer "charge_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["charge_id"], name: "index_payment_receipts_on_charge_id"
  end

  create_table "pixes", force: :cascade do |t|
    t.string "pix_key"
    t.integer "bank_code"
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_pixes_on_company_id"
    t.index ["payment_method_id"], name: "index_pixes_on_payment_method_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", null: false
    t.integer "discount"
    t.string "token"
    t.integer "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0, null: false
    t.integer "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "boletos", "companies"
  add_foreign_key "boletos", "payment_methods"
  add_foreign_key "charges", "boletos"
  add_foreign_key "charges", "companies"
  add_foreign_key "charges", "credit_cards"
  add_foreign_key "charges", "end_users"
  add_foreign_key "charges", "payment_methods"
  add_foreign_key "charges", "pixes"
  add_foreign_key "charges", "products"
  add_foreign_key "company_end_users", "companies"
  add_foreign_key "company_end_users", "end_users"
  add_foreign_key "company_payments", "companies"
  add_foreign_key "company_payments", "payment_methods"
  add_foreign_key "credit_cards", "companies"
  add_foreign_key "credit_cards", "payment_methods"
  add_foreign_key "payment_receipts", "charges"
  add_foreign_key "pixes", "companies"
  add_foreign_key "pixes", "payment_methods"
  add_foreign_key "users", "companies"
end
