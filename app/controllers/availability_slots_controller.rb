# frozen_string_literal: true

class AvailabilitySlotsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_slot, only: %i[index new create]

  def index
    respond_to do |format|
      format.html
      format.json do
        if current_user.teacher?
          availability_slots = AvailabilitySlot.free.available.where(teacher_id: current_user.id)
        elsif current_user.student?
          availability_slots = AvailabilitySlot.free.available.where(teacher_id: current_user.teachers.pluck(:id))
        end

        my_booked_slots = current_user.booked_slots.available

        available_slots = availability_slots + my_booked_slots

        overlapping_slots = find_overlapping_slots(available_slots)

        available_slots_final = available_slots.map do |slot|
          overlap = overlapping_slots.flatten.include?(slot)
          {
            title: my_booked_slots.include?(slot) ? 'Booked' : 'Available',
            start: slot.start_time,
            end: slot.end_time,
            overlap: true,
            color: my_booked_slots.include?(slot) ? '#ff0000' : '',
            extendedProps: {
              description: overlap ? 'This slot is overlapping.' : 'Available slot.',
              availability_slot_id: slot.id,
              overlapped: overlap,
              teacher: current_user.teacher?
            }
          }
        end
        render json: available_slots_final
      end
    end
  end

  def new
    @availability_slot = AvailabilitySlot.new
  end

  def create
    @availability_slot = AvailabilitySlot.new(availability_slot_params.merge(teacher: current_user))
    if @availability_slot.save
      redirect_to new_availability_slot_path, notice: 'Slot created successfully.'
    else
      render :new
    end
  end

  def destroy
    availability_slot = AvailabilitySlot.find(params[:id])
    authorize availability_slot

    availability_slot.destroy

    render :index
  end

  private

  def availability_slot_params
    params.require(:availability_slot).permit(:start_time, :end_time)
  end

  def find_overlapping_slots(slots)
    overlapping_slots = []

    slots.each_with_index do |slot1, i|
      slots[(i + 1)..].each do |slot2|
        next unless slot2.booked?

        overlapping_slots << [slot1, slot2] if slot1.start_time < slot2.end_time && slot2.start_time < slot1.end_time
      end
    end

    overlapping_slots
  end

  def authorize_slot
    authorize AvailabilitySlot
  end
end
