class Admin::RentalPolicy < ApplicationPolicy
  attr_reader :user, :rental

  def initialize(user, rental)
    @user = user
    @rental = rental
  end

  def create?
    user.regular?
  end

  def new?
    create?
  end

  def update?
    user.regular?
  end
 
  def edit?
    update?
  end

  def destroy?
    user.regular?
  end
end
