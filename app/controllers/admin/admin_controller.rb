module Admin
  class AdminController < ApplicationController
    layout 'admin'
    require_authentication
  end
end
