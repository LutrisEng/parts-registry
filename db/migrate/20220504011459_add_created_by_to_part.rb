# frozen_string_literal: true

class AddCreatedByToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :created_by, :string
  end
end
