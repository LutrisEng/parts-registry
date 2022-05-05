# frozen_string_literal: true

class HarmonizedSystemCode < ApplicationRecord
  def self.download!
    io = URI.open 'https://raw.githubusercontent.com/datasets/harmonized-system/a72bef25b2749cd04a824b8b46b71c89e566b4bb/data/harmonized-system.csv'
    raise StandardError, "Couldn't reach HS codes" if io.nil?

    csv = CSV.new(io, headers: true)
    while (row = csv.shift)
      hash = row.to_hash.deep_symbolize_keys
      next if hash[:hscode].nil?

      attrs = {
        section: hash[:section],
        hscode: hash[:hscode],
        description: hash[:description],
        parent: hash[:parent],
        level: Integer(hash[:level])
      }
      HarmonizedSystemCode.create!(attrs)
    end
  end
end
