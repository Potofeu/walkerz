class HikePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      scope.all
    end

    def index?
      true
    end

  end

  def show?
    true
  end

  def show?
    true
  end
end
