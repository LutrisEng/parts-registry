# frozen_string_literal: true

class User
  attr_reader :jwt, :decoded, :payload, :header

  def initialize(jwt)
    if jwt == :dev
      @dev = true
      @jwt = ''
      @decoded = {}
      @payload = { email: 'piper@lutris.group' }
      @header = {}
    else
      @dev = false
      @jwt = jwt
      @decoded = Auth::CloudflareAccess.decode(jwt)
      @payload = @decoded[0].deep_symbolize_keys
      @header = @decoded[1].deep_symbolize_keys
    end
  end

  def dev?
    @dev
  end

  def email
    payload[:email]
  end

  def identity
    if dev?
      {}
    else
      Auth::CloudflareAccess.identity(email, jwt)
    end
  end

  def employee?
    true
  end

  def admin?
    true
  end
end
