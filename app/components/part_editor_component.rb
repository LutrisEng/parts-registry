# frozen_string_literal: true

class PartEditorComponent < ViewComponent::Base
  delegate :rich_text_area_tag, to: :helpers

  def initialize(user:, part:)
    super
    @user = user
    @part = part
    @creating = part.new_record?
  end
end
