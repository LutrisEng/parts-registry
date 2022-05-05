# frozen_string_literal: true

module Form
  class FileFieldComponent < ViewComponent::Form::FileFieldComponent
    def html_class
      'block w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 cursor-pointer dark:text-gray-400 p-2.5 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 col-span-6 md:col-span-4 lg:col-span-5'
    end
  end
end
