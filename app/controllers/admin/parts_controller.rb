# frozen_string_literal: true

module Admin
  class PartsController < AdminController
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    def find_part
      authorize Part.find_by_part_number(params[:part_number])
    end

    def index
      @parts = policy_scope(Part)
    end

    def show
      @part = find_part
    end

    def new
      @part = authorize Part.new
    end

    def create
      part = authorize Part.new(part_params)
      part.created_by = current_user.email
      part.save!
      flash[:notice] = 'Part created!'
      redirect_to admin_part_path(part), status: :see_other
    end

    def edit
      @part = find_part
    end

    def update
      part = find_part
      part.update!(part_params)
      flash[:notice] = 'Part updated!'
      redirect_to admin_part_path(part), status: :see_other
    end

    def destroy
      find_part.destroy!
      flash[:notice] = 'Part destroyed!'
      redirect_to admin_parts_path, status: :see_other
    end

    def create_shopify
      part = find_part
      part.create_shopify_product!
      flash[:notice] = 'Shopify product created!'
      redirect_to admin_part_path(part), status: :see_other
    end

    def destroy_shopify
      part = find_part
      part.destroy_shopify_product!
      part.save!
      flash[:notice] = 'Shopify product destroyed!'
      redirect_to admin_part_path(part), status: :see_other
    end

    private

    def part_params
      params.require(:part).permit(
        :part_number,
        :name,
        :status,
        :description,
        :vendor,
        :mass_grams,
        :country_of_origin,
        :hs_code
      )
    end
  end
end
