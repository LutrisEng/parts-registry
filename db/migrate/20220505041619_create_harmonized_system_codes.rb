# frozen_string_literal: true

class CreateHarmonizedSystemCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :harmonized_system_codes do |t|
      t.string :section
      t.string :hscode
      t.string :description
      t.string :parent
      t.integer :level

      t.timestamps
    end
    add_index :harmonized_system_codes, :hscode
  end
end
