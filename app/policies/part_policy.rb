# frozen_string_literal: true

class PartPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if employee?
        scope.all
      else
        scope.where(status: Part::PUBLIC_STATUSES.map(&:to_s))
      end
    end
  end

  def public?
    record&.public?
  end

  def index?
    employee? || public?
  end

  def show?
    employee? || public?
  end

  def create?
    employee?
  end

  def update?
    employee?
  end

  def destroy?
    admin?
  end

  def create_shopify?
    admin? && public?
  end

  def destroy_shopify?
    admin?
  end
end
