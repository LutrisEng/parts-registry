# frozen_string_literal: true

class IndexController < ApplicationController
  def index
    redirect_to parts_path
  end
end
