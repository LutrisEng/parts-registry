# frozen_string_literal: true

module Form
  class ButtonComponent < ViewComponent::Form::ButtonComponent
    def html_class
      BaseButtonComponent::STYLES[:secondary]
    end
  end
end
