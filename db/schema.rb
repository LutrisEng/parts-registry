# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_220_504_015_438) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'part_attachments', force: :cascade do |t|
    t.string 'ipfs_cid'
    t.string 'filename'
    t.string 'description'
    t.string 'type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'parts', force: :cascade do |t|
    t.string 'part_number'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'status', null: false
    t.string 'created_by'
    t.index ['part_number'], name: 'index_parts_on_part_number'
  end
end
