# frozen_string_literal: true

class RabbitmqService
  def self.publish(queue, message)
    connection = if ENV['RABBITMQ_URL'].present?
                   Bunny.new(host: 'rabbitmq', port: 5672, automatically_recover: true)
                 else
                   Bunny.new
                 end
    connection.start

    channel = connection.create_channel
    queue = channel.queue(queue)

    channel.default_exchange.publish(message.to_json, routing_key: queue.name)
    connection.close
  end
end
