# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    availability_slot = AvailabilitySlot.find(params[:availability_slot_id].to_i)
    booking = Booking.new(availability_slot: availability_slot, user: current_user)

    if booking.save
      RabbitmqService.publish('analytics_queue', {
                                event: 'new_booking',
                                teacher_id: booking.availability_slot.teacher_id,
                                student_id: booking.user_id,
                                slot_id: booking.availability_slot_id,
                                start_time: booking.availability_slot.start_time
                              })
      redirect_to availability_slots_path, notice: 'Booking created successfully.'
    else
      redirect_to availability_slots_path, alert: 'Unable to create booking.'
    end
  end
end