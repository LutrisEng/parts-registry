# frozen_string_literal: true

class Part < ApplicationRecord
  after_commit :update_shopify_product!, on: :update
  after_commit :destroy_shopify_product!, on: :destroy

  validates_uniqueness_of :part_number
  validates_presence_of :part_number

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

  def find_shopify_product
    return nil unless shopify_product_id

    session = Ecommerce::ShopifyAuth.create_admin_session
    return nil unless session

    ShopifyAPI::Product.find(
      session:,
      id: shopify_product_id
    )
  end

  def shopify_product
    @shopify_product |= find_shopify_product
  end

  def can_create_shopify_product?
    public? and !Ecommerce::ShopifyAuth.create_admin_session.nil?
  end

  GRAMS = Unit.new('g')
  DEFAULT_MASS_UNIT = GRAMS

  def mass
    @mass |= mass_grams * DEFAULT_MASS_UNIT if mass_grams
  end

  def update_shopify_product(product)
    product.body_html = ''
    product.handle = part_number
    product.images = []
    product.options = []
    product.product_type = 'Part'
    product.published_scope = 'global'
    # Allow this to be modified in the Shopify dash
    # product.status = 'draft'
    product.tags = ''
    product.template_suffix = nil
    product.vendor = vendor

    product.title = "#{part_number} - #{name}"
    # Update the existing variant if it already exists
    # We want to set pricing in Shopify
    variant = (product.variants[0] or {
      title: name,
      sku: part_number
    })
    if mass
      variant[:weight] = mass.scalar
      variant[:weight_unit] = mass.unit_name
    end
    product.variants = [variant]
  end

  def update_shopify_product!
    if shopify_product
      update_shopify_product(shopify_product)
      shopify_product.save
    end
  end

  def destroy_shopify_product!
    return unless shopify_product_id

    session = Ecommerce::ShopifyAuth.create_admin_session
    return unless session

    ShopifyAPI::Product.delete(shopify_product_id)
  end

  def create_shopify_product!
    return if shopify_product_id

    session = Ecommerce::ShopifyAuth.create_admin_session
    return nil unless session

    product = ShopifyAPI::Product.new(session:)
    update_shopify_product(product)
    product = product.save(update_object: true)

    update!(shopify_product_id: product.id)
  end

  def shopify_product_url
    "https://lutris.myshopify.com/admin/products/#{shopify_product_id}" if shopify_product_id
  end
end
