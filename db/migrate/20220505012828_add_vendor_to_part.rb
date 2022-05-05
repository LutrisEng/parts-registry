class AddVendorToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :vendor, :string
    add_index :parts, :vendor
  end
end
