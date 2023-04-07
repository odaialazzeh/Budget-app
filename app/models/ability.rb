class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return unless user.present?

    can :read, Group, user_id: user.id
    can :read, Payment, user_id: user.id

    can :manage, Group, user_id: user.id
    can :manage, Payment, user_id: user.id

    return unless user.admin?

    can :manage, :all # finally we give all remaining permissions only to the admins
  end
end
