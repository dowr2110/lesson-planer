class PagesController < ApplicationController
  def home
    if user_signed_in? && current_user.teacher?
      @profile = current_user.teacher_profile
    elsif user_signed_in? && current_user.student?
      @profile = current_user.student_profile
    end

    @report_data = fetch_monthly_report
  end

  private

  def fetch_monthly_report
    uri = URI("#{ENV.fetch('ANALYTICS_SERVICE_URL', 'http://localhost:3001')}/booking_reports/monthly")
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = ENV['API_AUTH_TOKEN']

    begin
      response = Net::HTTP.start(uri.hostname, uri.port, read_timeout: 10) do |http| # Устанавливаем таймаут 10 секунд
        http.request(request)
      end

      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        Rails.logger.error("Analytics service responded with error: #{response.code}")
        {}
      end
    rescue Timeout::Error, Errno::ECONNREFUSED => e
      Rails.logger.error("Error connecting to analytics service: #{e.message}")
      {}
    end
  end
end
