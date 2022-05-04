# frozen_string_literal: true

class PartViewerComponent < ViewComponent::Base
  def self.status_class(status)
    case status
    when 'draft'
      'bg-blue-100 text-blue-800'
    when 'rtm'
      'bg-green-100 text-green-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

  def initialize(part:)
    super
    @part = part
    @status_class = PartViewerComponent.status_class(part.status)
  end
end
