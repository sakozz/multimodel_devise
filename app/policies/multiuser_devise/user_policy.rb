module MultiuserDevise
  class UserPolicy < ApplicationPolicy
    def create?
      true
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
