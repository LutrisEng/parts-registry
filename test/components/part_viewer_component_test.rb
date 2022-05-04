# frozen_string_literal: true

require 'test_helper'

class PartViewerComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    # assert_equal(
    #   %(<span>Hello, components!</span>),
    #   render_inline(PartViewerComponent.new(message: "Hello, components!")).css("span").to_html
    # )
  end

  def test_every_status_has_a_color
    fallback = PartViewerComponent.status_class(:nonexistent_status)
    Part::ALL_STATUSES.each do |status|
      assert_not_equal(fallback, PartViewerComponent.status_class(status), status)
    end
  end
end
