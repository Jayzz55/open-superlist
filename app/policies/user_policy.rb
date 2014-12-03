 class UserPolicy < ApplicationPolicy
  def index?
    user == record
  end

  def show?
    user.present? && (user == record)
  end

  def create?
    user.present? && (user == record)
  end

  def update?
    user.present? && (record == user)
  end

 end