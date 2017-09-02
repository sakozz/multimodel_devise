module MultiuserDevise
  class AdminPolicy < ApplicationPolicy
    def create?
      resource_is_admin?
    end

    def create_session?
      true
    end

    class Scope < Scope
      def resolve
        scope
      end
    end


  end
end
