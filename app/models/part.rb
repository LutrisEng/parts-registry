# frozen_string_literal: true

class Part < ApplicationRecord
  validates_uniqueness_of :part_number
  validates_presence_of :part_number

  ALL_STATUSES = %i[draft rtm].freeze
  PUBLIC_STATUSES = %i[rtm].freeze
  enum status: ALL_STATUSES.zip(ALL_STATUSES.map(&:to_s)).to_h

  def public?
    PUBLIC_STATUSES.include? status.to_sym
  end

  def to_param
    part_number
  end

  def status_t
    "status.#{status}.long"
  end

  def short_status_t
    "status.#{status}.short"
  end
end
