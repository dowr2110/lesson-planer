class ChatPolicy < ApplicationPolicy
  def show?
    user == record.teacher || user == record.student
  end

  def create?
    user == record.teacher || user == record.student
  end

  class Scope < ApplicationPolicy::Scope

  end
end
