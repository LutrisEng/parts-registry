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

ActiveRecord::Schema[7.0].define(version: 20_220_506_203_317) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'action_text_rich_texts', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'body'
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[record_type record_id name], name: 'index_action_text_rich_texts_uniqueness', unique: true
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'harmonized_system_codes', force: :cascade do |t|
    t.string 'section'
    t.string 'hscode'
    t.string 'description'
    t.string 'parent'
    t.integer 'level'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['hscode'], name: 'index_harmonized_system_codes_on_hscode'
  end

  create_table 'part_attachments', force: :cascade do |t|
    t.string 'ipfs_cid'
    t.string 'filename'
    t.string 'description'
    t.string 'type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'part_relations', force: :cascade do |t|
    t.bigint 'part_a_id', null: false
    t.string 'relation_type', null: false
    t.bigint 'part_b_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['part_a_id'], name: 'index_part_relations_on_part_a_id'
    t.index ['part_b_id'], name: 'index_part_relations_on_part_b_id'
  end

  create_table 'parts', force: :cascade do |t|
    t.string 'part_number'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'status', null: false
    t.string 'created_by'
    t.integer 'shopify_product_id'
    t.float 'mass_grams'
    t.string 'vendor'
    t.string 'country_of_origin'
    t.string 'hs_code'
    t.string 'prop_65'
    t.index ['part_number'], name: 'index_parts_on_part_number'
    t.index ['shopify_product_id'], name: 'index_parts_on_shopify_product_id'
    t.index ['vendor'], name: 'index_parts_on_vendor'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'part_relations', 'parts', column: 'part_a_id'
  add_foreign_key 'part_relations', 'parts', column: 'part_b_id'
end
