# frozen_string_literal: true

class CreatePartAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :part_attachments do |t|
      t.string :ipfs_cid
      t.string :filename
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
