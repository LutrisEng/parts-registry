# frozen_string_literal: true

class AddShopifyProductIdToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :shopify_product_id, :integer
    add_index :parts, :shopify_product_id
  end
end
