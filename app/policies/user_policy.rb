 class UserPolicy < ApplicationPolicy
  def index?
    user == record
  end

  def show?
    authorize_check
  end

  def create?
    authorize_check
  end

  def update?
    authorize_check
  end

  def destroy_multiple?
    authorize_check
  end

  private

  def authorize_check
    user.present? && (user == record)
  end

 end