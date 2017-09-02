class ApplicationPolicy
  attr_reader :resource, :record

  def initialize(resource, record)
    @resource = resource
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(resource, record.class)
  end

  def resource_is_admin?
    resource.present? && resource.class.name =="MultiuserDevise::Admin"
  end

  class Scope
    attr_reader :resource, :scope

    def initialize(resource, scope)
      @resource = resource
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

