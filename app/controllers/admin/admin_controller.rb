# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    layout 'admin'
    require_authentication
  end
end
