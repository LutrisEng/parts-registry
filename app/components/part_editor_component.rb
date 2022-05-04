# frozen_string_literal: true

class PartEditorComponent < ViewComponent::Base
  def initialize(user:, part:)
    super
    @user = user
    @part = part
    @creating = part.new_record?
  end
end
