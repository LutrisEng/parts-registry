# frozen_string_literal: true

module Ecommerce
  module ShopifyAuth
    def credentials
      Rails.application.credentials.dig(Rails.env.to_sym, :shopify)
    end
    module_function :credentials

    def create_admin_session
      ShopifyAPI::Context.load_rest_resources(api_version: '2022-01')

      return nil unless credentials

      ShopifyAPI::Auth::Session.new(shop: credentials[:shop], access_token: credentials[:admin_api_token])
    end
    module_function :create_admin_session

    shopify_session = Ecommerce::ShopifyAuth.create_admin_session
    ShopifyAPI::Context.activate_session(shopify_session) if shopify_session
  end
end
