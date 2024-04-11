class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  # def index?
  #   true
  # end

  def new?
    create?
  end

  def create?
    true
  end

  def show?
    record.user == user || record.public == true
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end
end
