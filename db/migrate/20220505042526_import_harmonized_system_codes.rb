# frozen_string_literal: true

class ImportHarmonizedSystemCodes < ActiveRecord::Migration[7.0]
  def up
    HarmonizedSystemCode.download!
  end

  def down
    HarmonizedSystemCode.delete_all
  end
end
