# frozen_string_literal: true

class ZoomMeeting
  # prepend ApplicationService
  # include Dry::Monads::Do.for(:call)
  #
  # ZOOM_CLIENT_ID = ENV['ZOOM_CLIENT_ID']
  # ZOOM_CLIENT_SECRET = ENV['ZOOM_CLIENT_SECRET']
  #
  # def initialize(redirect_uri: nil, authorization_code: nil, access_token: nil)
  #   @authorization_code = authorization_code
  #   @access_token = access_token.nil? ? fetch_access_token : access_token
  #   @redirect_uri = redirect_uri
  # end
  #
  # def call
  #   Success(create_meeting)
  # end
  #
  # def fetch_access_token
  #   response = Faraday.post('https://zoom.us/oauth/token') do |req|
  #     req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
  #     req.body = {
  #       grant_type: 'authorization_code',
  #       code: @authorization_code,
  #       redirect_uri: @redirect_uri,
  #       client_id: ZOOM_CLIENT_ID,
  #       client_secret: ZOOM_CLIENT_SECRET
  #     }.to_query
  #   end
  #
  #   access_token, expires_in = handle_response(response)['access_token']
  #   expires_at = Time.current + expires_in.to_i.seconds
  #   session[:zoom_access_token] = { token: access_token, expires_at: expires_at }
  #
  #   handle_response(response)['access_token']
  # end
  #
  # private
  #
  # attr_accessor :redirect_uri, :access_token, :authorization_code
  #
  # def create_meeting
  #   response = Faraday.post('https://api.zoom.us/v2/users/me/meetings') do |req|
  #     req.headers['Authorization'] = "Bearer #{@access_token}"
  #     req.headers['Content-Type'] = 'application/json'
  #     req.body = {
  #       topic: 'My Meeting',
  #       type: 2,
  #       start_time: '2023-09-06T10:00:00Z',
  #       duration: 60,
  #       settings: {
  #         host_video: true,
  #         participant_video: true
  #       }
  #     }.to_json
  #   end
  #
  #   handle_response(response)['join_url']
  # end
  #
  # def handle_response(response)
  #   case response.status
  #   when 200
  #     JSON.parse(response.body)
  #   else
  #     Failure("Zoom API error: #{response.status} #{response.body}")
  #   end
  # end
end
