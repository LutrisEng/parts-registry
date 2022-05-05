# frozen_string_literal: true

class AddHsCodeToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :hs_code, :string
  end
end
