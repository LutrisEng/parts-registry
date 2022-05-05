# frozen_string_literal: true

class AddCountryOfOriginToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :country_of_origin, :string
  end
end
