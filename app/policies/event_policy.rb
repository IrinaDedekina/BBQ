# В этом полиси должно быть 3 экшена для правки события
# (update, destroy) и 1 для отображения (show)

class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def edit?
    user_is_owner?(record)
  end

  def destroy?
    edit?
  end

  def show?
    true
  end

  def update?
    edit?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_is_owner?(model)
    user.present? && (model.try(:user) == user)
  end
end
