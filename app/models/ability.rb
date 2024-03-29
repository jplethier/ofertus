class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    can :today, Deal
    can :read, User
    can :read, Deal
    can :read, Comment
    can :feed, Deal
    can :invite, User
    can :followers, User
    can :following, User

    unless user.guest?
      can :manage, Deal, :user_id => user.id
      can [:follow, :unfollow], User
      can :manage, Comment
      can [:upvote, :downvote, :unvote], Deal
      can :sales, User, :id => user.id
      can :friends, User, :id => user.id
      can :notifications, User, :id => user.id
      can :withdraw, User, :id => user.id
      can :update, User, :id => user.id
      can :manage, Notification, :user_id => user.id
    end

    if user.admin?
      can :manage, User
      can :manage, Deal
      can :manage, Sale
      can :manage, Product
      can :manage, Banner
    end
  end
end
