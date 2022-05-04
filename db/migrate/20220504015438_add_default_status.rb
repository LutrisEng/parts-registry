# frozen_string_literal: true

class AddDefaultStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_null :parts, :status, false, 'draft'
  end
end
