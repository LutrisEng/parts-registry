# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  helper_method :current_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    @current_user ||= read_user
  end

  def self.require_authentication
    before_action :require_authentication!
  end

  def require_authentication!
    render file: 'public/401.html', status: :unauthorized if current_user.nil?
  end

  def user_not_authorized
    render file: 'public/401.html', status: :unauthorized
  end

  private

  def read_user
    if Rails.env.development?
      User.new(:dev)
    else
      token = request.headers[Auth::CloudflareAccess::HEADER]
      User.new(token) unless token.nil?
    end
  end
end
