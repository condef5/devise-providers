class Admin::RentalPolicy < ApplicationPolicy
  attr_reader :user, :rental

  def initialize(user, rental)
    @user = user
    @rental = rental
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def update?
    user.admin?
  end
 
  def edit?
    update?
  end

  def destroy?
    user.admin?
  end
end
