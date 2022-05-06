class AddProp65ToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :prop_65, :string
  end
end
