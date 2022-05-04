# frozen_string_literal: true

require 'test_helper'

class BaseButtonComponentTest < ViewComponent::TestCase
  def test_component_renders_content
    render_inline(BaseButtonComponent.new(path: 'https://google.com')) { 'Hello, world!' }
    assert_text('Hello, world!')
  end

  def test_component_renders_path
    render_inline(BaseButtonComponent.new(path: 'https://google.com')) { 'Hello, world!' }
    assert_selector :css, 'a[href="https://google.com"]', text: 'Hello, world!'
  end
end
