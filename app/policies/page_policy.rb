class PagePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def home?
    true
  end

  def about_us?
    true
  end

  def profile?
    true
  end
end
