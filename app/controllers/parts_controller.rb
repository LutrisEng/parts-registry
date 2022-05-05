# frozen_string_literal: true

class PartsController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def find_part
    authorize Part.find_by_part_number!(params[:part_number])
  end

  def index
    @parts = policy_scope(Part)
  end

  def show
    @part = find_part
  end
end
