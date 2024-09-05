class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    availability_slot = AvailabilitySlot.find(params[:availability_slot_id].to_i)
    booking = Booking.new(availability_slot: availability_slot, user: current_user)

    if booking.save
      redirect_to availability_slots_path, notice: 'Booking created successfully.'
    else
      redirect_to availability_slots_path, alert: 'Unable to create booking.'
    end
  end
end