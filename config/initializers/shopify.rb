# frozen_string_literal: true

shopify_session = Ecommerce::ShopifyAuth.create_admin_session
ShopifyAPI::Context.activate_session(shopify_session) if shopify_session
