# frozen_string_literal: true

class Part < ApplicationRecord
  has_one_attached :image
  has_many_attached :attachments

  after_commit :update_shopify_product!, on: :update
  after_commit :destroy_shopify_product!, on: :destroy

  validates_uniqueness_of :part_number
  validates_presence_of :part_number
  validates_inclusion_of :country_of_origin,
                         in: IsoCountryCodes.all.map(&:alpha2),
                         message: '%{value} is not a valid ISO 3166-1 alpha-2 country code.',
                         allow_nil: true,
                         allow_blank: true

  ALL_STATUSES = %i[draft prototype engineering_sample private_shelved public_draft public_shelved rtm eol].freeze
  PUBLIC_STATUSES = %i[public_draft public_shelved rtm eol].freeze
  enum status: ALL_STATUSES.zip(ALL_STATUSES.map(&:to_s)).to_h

  has_rich_text :description

  def public?
    PUBLIC_STATUSES.include? status.to_sym
  end

  def to_param
    part_number
  end

  def self.status_to_t(status)
    "status.#{status}.long"
  end

  def status_t
    Part.status_to_t(status)
  end

  def self.status_to_short_t(status)
    "status.#{status}.short"
  end

  def short_status_t
    Part.status_to_short_t(status)
  end

  def shopify_session
    @shopify_session ||= Ecommerce::ShopifyAuth.create_admin_session
  end

  def shopify_session!
    raise StandardError, 'Missing Shopify session!' unless shopify_session

    shopify_session
  end

  def find_shopify_product
    return nil unless shopify_product_id
    return nil unless shopify_session

    begin
      ShopifyAPI::Product.find(
        session: shopify_session,
        id: shopify_product_id
      )
    rescue ShopifyAPI::Errors::HttpResponseError => e
      raise e unless e.code == 404

      update!(shopify_product_id: nil)
      nil
    end
  end

  def shopify_product
    @shopify_product ||= find_shopify_product
  end

  def can_create_shopify_product?
    public? and shopify_session
  end

  GRAMS = Unit.new('g')
  DEFAULT_MASS_UNIT = GRAMS

  def mass
    mass_grams * DEFAULT_MASS_UNIT if mass_grams
  end

  def sentry_transaction
    Sentry.get_current_scope&.get_transaction || Sentry.start_transaction
  end

  def update_shopify_product(product)
    product.body_html = description.to_s
    product.handle = part_number
    # product.images = []
    # product.options = []
    product.product_type = 'Part'
    product.published_scope = 'global'
    # Allow this to be modified in the Shopify dash
    product.status = 'draft' if product.status.nil?
    product.tags = ''
    product.template_suffix = nil
    product.vendor = vendor
    product.published_scope = 'global'
    product.title = "#{part_number} - #{name}"
    # Update the existing variant if it already exists
    # We want to set pricing in Shopify
    product.variants = [] if product.variants.nil?
    variant = if product.variants.empty?
                ShopifyAPI::Variant.new(session: shopify_session)
              else
                product.variants.first
              end
    variant.title = name
    variant.sku = part_number
    if mass
      variant.weight = mass.convert_to('g').scalar.to_f
      variant.weight_unit = 'g'
    end
    product.variants[0] = variant
  end

  def product_variant_for_product(product)
    product.variants = [] if product.variants.nil?
    variant = if product.variants.empty?
                ShopifyAPI::Variant.new(session: shopify_session)
              else
                product.variants.first
              end
    product.variants[0] = variant
    variant
  end

  def inventory_item_for_product(product)
    variant = product_variant_for_product(product)
    return nil unless variant

    inventory_item_id = variant.inventory_item_id
    return nil unless inventory_item_id

    ShopifyAPI::InventoryItem.find(id: inventory_item_id, session: shopify_session)
  end

  def publish_shopify_product(product)
    span = sentry_transaction.start_child(op: :publish_shopify_product, description: 'Publish Shopify product')
    begin
      span.set_data(:product_id, product.id)

      client = ShopifyAPI::Clients::Graphql::Admin.new(
        session: shopify_session
      )

      query = <<~QUERY
        mutation publishProduct($id: ID!) {
          publishablePublishToCurrentChannel(id: $id) {
            publishable {
              availablePublicationCount
            }
          }
        }
      QUERY
      response = client.query(query:, variables: { id: "gid://shopify/Product/#{product.id}" })

      Sentry.add_breadcrumb(Sentry::Breadcrumb.new(
        category: 'shopify',
        message: 'Received response from publishProduct mutation',
        level: 'info',
        data: {
          code: response.code,
          headers: response.headers,
          body: response.body
        }
      ))
      raise StandardError, response.body[:errors].first[:message] if response.body[:errors]
    ensure
      span.finish
    end
  end

  def update_inventory_item(inventory_item)
    inventory_item.country_code_of_origin = country_of_origin
    inventory_item.harmonized_system_code = hs_code
    inventory_item.sku = part_number
  end

  def update_shopify_product!
    span = sentry_transaction.start_child(op: :update_shopify_product!, description: 'Update Shopify product')
    begin
      return unless shopify_product

      span.set_data(:product_id, shopify_product_id)

      update_shopify_product(shopify_product)
      shopify_product.save

      inventory_item = inventory_item_for_product(shopify_product)

      if inventory_item
        update_inventory_item(inventory_item)
        inventory_item.save
      end

      publish_shopify_product(shopify_product)
    ensure
      span.finish
    end
  end

  def destroy_shopify_product!
    span = sentry_transaction.start_child(op: :destroy_shopify_product!, description: 'Destroy Shopify product')
    begin
      return unless shopify_product_id

      span.set_data(:product_id, shopify_product_id)

      ShopifyAPI::Product.delete(id: shopify_product_id, session: shopify_session!)

      self.shopify_product_id = nil
    ensure
      span.finish
    end
  end

  def create_shopify_product!
    span = sentry_transaction.start_child(op: :create_shopify_product!, description: 'Create Shopify product')
    begin
      return if shopify_product_id

      product = ShopifyAPI::Product.new(session: shopify_session!)
      update_shopify_product(product)
      product.save(update_object: true)
      update_shopify_product!

      update!(shopify_product_id: product.id)
    ensure
      span.finish
    end
  end

  def shopify_product_url
    "https://lutris.myshopify.com/admin/products/#{shopify_product_id}" if shopify_product_id
  end

  def shopify_storefront_id
    product = shopify_product
    return unless shopify_product

    variant = product_variant_for_product(product)
    return unless variant

    Base64.encode64("gid://shopify/ProductVariant/#{variant.id}").strip
  end

  def hs_code_description
    HarmonizedSystemCode.find_by_extended_hscode(hs_code)&.description unless hs_code.nil?
  end
end
