# frozen_string_literal: true

require 'test_helper'

class InputGroupComponentTest < ViewComponent::TestCase
  def test_component_renders_content
    render_inline(InputGroupComponent.new) { 'Hello, world!' }
    assert_text('Hello, world!')
  end
end
