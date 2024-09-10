class PagesController < ApplicationController
  def home
    if user_signed_in? && current_user.teacher?
      @profile = current_user.teacher_profile
    elsif user_signed_in? && current_user.student?
      @profile = current_user.student_profile
    end

    puts 'micro-service check'
    puts fetch_daily_report
  end

  private

  def fetch_daily_report(date = Date.today)
    uri = URI("http://localhost:3001/booking_reports/daily?date=#{date}")
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = ENV['API_AUTH_TOKEN']

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end
end
