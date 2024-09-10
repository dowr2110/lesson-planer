class RabbitmqService
  def self.publish(queue, message)
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    queue = channel.queue(queue)

    channel.default_exchange.publish(message.to_json, routing_key: queue.name)
    connection.close
  end
end