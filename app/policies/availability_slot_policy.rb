class AvailabilitySlotPolicy < ApplicationPolicy
  def index?
    user.student? || user.teacher?
  end

  def new?
    user.teacher?
  end

  def create?
    user.teacher?
  end

  def destroy?
    user == record.teacher
  end

  # USAGE: policy_scope(AvailabilitySlot) in availability_slots_controller index
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.teacher?
        scope.free.available.where(teacher_id: user.id)
      elsif user.student?
        scope.free.available
      end
    end
  end
end
