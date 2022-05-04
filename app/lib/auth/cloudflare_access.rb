# frozen_string_literal: true

module Auth
  module CloudflareAccess
    extend self

    CFACCESS_DOMAIN = 'lutris.cloudflareaccess.com'
    HEADER = 'Cf-Access-Jwt-Assertion'
    ISS = "https://#{CFACCESS_DOMAIN}".freeze
    JWKS_URL = "https://#{CFACCESS_DOMAIN}/cdn-cgi/access/certs".freeze
    JWKS_CACHE_KEY = 'auth/jwks-json'
    IDENTITY_URL = "https://#{CFACCESS_DOMAIN}/cdn-cgi/access/get-identity".freeze
    IDENTITY_CACHE_KEY_PREFIX = 'auth/cf-identity/'

    def decode(token)
      JWT.decode(
        token,
        nil,
        true,
        algorithms: ['RS256'],
        iss: ISS,
        verify_iss: true,
        aud: Rails.configuration.cf_access_aud,
        verify_aud: true,
        jwks: jwks_loader
      )
    end

    def identity(email, token)
      Rails.cache.fetch(identity_cache_key(email)) do
        fetch_identity(token)
      end
    end

    private

    def fetch_jwks
      response = HTTParty.get(JWKS_URL)
      JSON.parse(response.body.to_s) if response.code == 200
    end

    def jwks(force: false)
      Rails.cache.fetch(JWKS_CACHE_KEY, force:, skip_nil: true) do
        fetch_jwks
      end&.deep_symbolize_keys
    end

    def jwks_loader
      lambda do |options|
        jwks(force: options[:invalidate]) || {}
      end
    end

    def identity_cache_key(email)
      IDENTITY_CACHE_KEY_PREFIX + email
    end

    def fetch_identity(token)
      response = HTTParty.get(IDENTITY_URL, headers: {
                                "Cookie": "CF_Authorization=#{token}"
                              })
      JSON.parse(response.body.to_s) if response.code == 200
    end
  end
end
