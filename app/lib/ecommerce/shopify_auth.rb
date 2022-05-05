# frozen_string_literal: true

module Ecommerce
  module ShopifyAuth
    module_function :create_admin_session, :create_admin_client

    def create_admin_session
      credentials = Rails.application.credentials.dig(Rails.env.to_sym, :shopify)
      return nil unless credentials

      ShopifyAPI::Utils::SessionUtils.load_current_session(
        auth_header: credentials[:admin_api_token]
      )
    end
  end
end
