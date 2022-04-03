require "bunny"
require "json"

module Events
  module Messaging
    class Producer
      include ::Helpers::Display

      ERROR_MESSAGES = [
        "ERR: Failed to connect to RabbitMQ Server!. Make sure RabbitMQ is running and properly configured.",
        "ERR: Events will *not* be transmitted."
      ].freeze

      def initialize
        connection = Bunny.new
        connection.start

        @channel = connection.create_channel
        @queue = @channel.queue("game_events")
      rescue Bunny::TCPConnectionFailed
        ERROR_MESSAGES.each { puts in_red _1 }
      end

      def emit_event(payload)
        return unless @channel

        serialized_payload = build_payload(payload)
        @channel.default_exchange.publish(serialized_payload, routing_key: @queue.name)
      end

      private

      def build_payload(payload)
        payload.merge!(
          timestamp: Time.now,
        ).to_json
      end

    end
  end
end
