class AddMassToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :mass_grams, :float
  end
end
