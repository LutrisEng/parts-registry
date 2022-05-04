# frozen_string_literal: true

class AddStatusToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :status, :string
  end
end
