# frozen_string_literal: true

class PartViewerComponent < ViewComponent::Base
  def self.status_class(status)
    case status.to_sym
    when :draft
      'bg-blue-100 text-blue-800'
    when :prototype
      'bg-teal-100 text-teal-800'
    when :engineering_sample
      'bg-purple-100 text-teal-800'
    when :private_shelved
      'bg-orange-100 text-orange-800'
    when :public_draft
      'bg-blue-100 text-blue-800'
    when :public_shelved
      'bg-orange-100 text-orange-800'
    when :rtm
      'bg-green-100 text-green-800'
    when :eol
      'bg-red-100 text-red-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

  def initialize(part:, admin: false)
    super
    @part = part
    @status_class = PartViewerComponent.status_class(part.status)
    @admin = admin
  end
end
