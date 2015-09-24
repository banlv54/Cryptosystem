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

ActiveRecord::Schema.define(version: 20150924063038) do

  create_table "ciphers", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "max_length"
  end

  create_table "documents", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "cipher_id"
    t.string   "title"
    t.string   "encryption_type"
  end

  add_index "documents", ["cipher_id"], name: "index_documents_on_cipher_id"

  create_table "key_decas", force: :cascade do |t|
    t.string   "key"
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "key_decas", ["key"], name: "index_key_decas_on_key"

  create_table "key_hepta", force: :cascade do |t|
    t.string   "key"
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "key_hepta", ["key"], name: "index_key_hepta_on_key"

  create_table "key_hexas", force: :cascade do |t|
    t.string   "key"
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "key_hexas", ["key"], name: "index_key_hexas_on_key"

  create_table "key_nonas", force: :cascade do |t|
    t.string   "key"
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "key_nonas", ["key"], name: "index_key_nonas_on_key"

  create_table "key_octa", force: :cascade do |t|
    t.string   "key"
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "key_octa", ["key"], name: "index_key_octa_on_key"

  create_table "key_pairs", force: :cascade do |t|
    t.string   "key"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.string   "value"
  end

  add_index "key_pairs", ["key"], name: "index_key_pairs_on_key"

  create_table "key_penta", force: :cascade do |t|
    t.string   "key"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.string   "value"
  end

  add_index "key_penta", ["key"], name: "index_key_penta_on_key"

  create_table "key_quadruples", force: :cascade do |t|
    t.string   "key"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.string   "value"
  end

  add_index "key_quadruples", ["key"], name: "index_key_quadruples_on_key"

  create_table "key_singles", force: :cascade do |t|
    t.string   "key"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.string   "value"
  end

  add_index "key_singles", ["key"], name: "index_key_singles_on_key"

  create_table "key_triples", force: :cascade do |t|
    t.string   "key"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "tanso"
    t.decimal  "tansuat",    precision: 12, scale: 10
    t.string   "value"
  end

  add_index "key_triples", ["key"], name: "index_key_triples_on_key"

  create_table "page_contents", force: :cascade do |t|
    t.text     "title"
    t.text     "content"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "page_contents", ["link"], name: "index_page_contents_on_link"

end
