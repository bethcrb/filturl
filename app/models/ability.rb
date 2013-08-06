# The Ability class is where all user permissions are defined.
class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.has_role? :admin
  end
end
