# frozen_string_literal: true

module Form
  class LabelComponent < ViewComponent::Form::LabelComponent
    def html_class
      'block text-sm font-medium text-gray-700 dark:text-gray-300 my-auto col-span-6 md:col-span-2 lg:col-span-1'
    end
  end
end
