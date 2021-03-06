# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091114094141) do

  create_table "families", :force => true do |t|
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "external_contact_name",  :limit => 64
    t.string   "external_contact_phone", :limit => 32
  end

  create_table "meeting_places", :force => true do |t|
    t.integer  "family_id"
    t.integer  "position"
    t.string   "name",       :limit => 64
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "person_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.integer  "family_id"
    t.string   "name",       :limit => 64
    t.string   "phone",      :limit => 32
    t.string   "sms",        :limit => 32
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
