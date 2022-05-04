# frozen_string_literal: true

class Part < ApplicationRecord
  validates_uniqueness_of :part_number
  validates_presence_of :part_number

  ALL_STATUSES = %i[draft prototype engineering_sample private_shelved public_draft public_shelved rtm eol].freeze
  PUBLIC_STATUSES = %i[public_draft public_shelved rtm eol].freeze
  enum status: ALL_STATUSES.zip(ALL_STATUSES.map(&:to_s)).to_h

  has_rich_text :description

  def public?
    PUBLIC_STATUSES.include? status.to_sym
  end

  def to_param
    part_number
  end

  def self.status_to_t(status)
    "status.#{status}.long"
  end

  def status_t
    Part.status_to_t(status)
  end

  def self.status_to_short_t(status)
    "status.#{status}.short"
  end

  def short_status_t
    Part.status_to_short_t(status)
  end
end
