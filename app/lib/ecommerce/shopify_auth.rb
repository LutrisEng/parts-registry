# frozen_string_literal: true

module Ecommerce
  module ShopifyAuth
    def create_admin_session
      credentials = Rails.application.credentials.dig(Rails.env.to_sym, :shopify)
      return nil unless credentials

      ShopifyAPI::Auth::Session.new(shop: 'lutris', access_token: credentials[:admin_api_token])
    end
    module_function :create_admin_session
  end
end
