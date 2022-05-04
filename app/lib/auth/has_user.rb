# frozen_string_literal: true

module Auth
  module HasUser
    def admin?
      user&.admin?
    end

    def employee?
      user&.employee?
    end
  end
end
