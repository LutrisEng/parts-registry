# frozen_string_literal: true

class CreatePartRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :part_relations do |t|
      t.references :part_a, null: false, foreign_key: { to_table: :parts }
      t.string :relation_type, null: false
      t.references :part_b, null: false, foreign_key: { to_table: :parts }

      t.timestamps
    end
  end
end
