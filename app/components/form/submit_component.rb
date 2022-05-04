# frozen_string_literal: true

module Form
  class SubmitComponent < ViewComponent::Form::SubmitComponent
    def html_class
      BaseButtonComponent::STYLES[:primary] + ' col-span-6 md:col-span-2 lg:col-span-1'
    end
  end
end
