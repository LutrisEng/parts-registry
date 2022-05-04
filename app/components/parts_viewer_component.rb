# frozen_string_literal: true

class PartsViewerComponent < ViewComponent::Base
  def initialize(parts:, admin:)
    super
    @parts = parts
    @admin = admin
  end
end
