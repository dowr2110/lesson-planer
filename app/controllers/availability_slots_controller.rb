# frozen_string_literal: true

class AvailabilitySlotsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_slot, only: %i[index new create]
  before_action :zoom_authorization, only: :new

  ZOOM_CLIENT_ID = ENV['ZOOM_CLIENT_ID']
  ZOOM_CLIENT_SECRET = ENV['ZOOM_CLIENT_SECRET']

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
              teacher: current_user.teacher?,
              zoom_link: my_booked_slots.include?(slot) ? slot.meet_link : nil
            }
          }
        end
        render json: available_slots_final
      end
    end
  end

  def new
    fetch_access_token(params[:code], new_availability_slot_url) if access_token_session.nil?

    @availability_slot = AvailabilitySlot.new
  end

  def create
    zoom_meeting = create_meeting(access_token_session, availability_slot_params[:start_time])
    @availability_slot = AvailabilitySlot.new(availability_slot_params.merge(teacher: current_user, meet_link: zoom_meeting))
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

  def zoom_authorization
    if access_token_session.nil? && params[:code].nil?
      redirect_to "https://zoom.us/oauth/authorize?client_id=#{ENV['ZOOM_CLIENT_ID']}&response_type=code&redirect_uri=#{new_availability_slot_url}", allow_other_host: true
    end
  end

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

  def fetch_access_token(code, redirect_uri)
    response = Faraday.post('https://zoom.us/oauth/token') do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: redirect_uri,
        client_id: ZOOM_CLIENT_ID,
        client_secret: ZOOM_CLIENT_SECRET
      }.to_query
    end

    access_token = JSON.parse(response.body)['access_token']
    expires_at = Time.current + 1.hour
    session[:zoom_client_access_token] = { token: access_token, expires_at: expires_at }

    redirect_to new_availability_slot_path, notice: 'Zoom authorized successfully, Thank you for time'
  end

  def create_meeting(access_token, start_time)
    response = Faraday.post('https://api.zoom.us/v2/users/me/meetings') do |req|
      req.headers['Authorization'] = "Bearer #{access_token}"
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        topic: 'My Meeting',
        type: 2,
        start_time: start_time,
        duration: 60,
        settings: {
          host_video: true,
          participant_video: true
        }
      }.to_json
    end

    JSON.parse(response.body)['join_url']
  end

  def access_token_session
    token_data = session[:zoom_client_access_token]

    token_data['token'] if token_data.present? && Time.current < Time.parse(token_data['expires_at'])
  end
end
