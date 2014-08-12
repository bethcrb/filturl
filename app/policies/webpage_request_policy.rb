# Authorization policy for WebpageRequest
class WebpageRequestPolicy < ApplicationPolicy
  def new?
    user
  end

  def show?
    user
  end

  def create?
    user
  end

  # Determines which WebpageRequest records a user has access to
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
