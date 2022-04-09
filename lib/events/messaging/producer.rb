require "bunny"
require "json"

module Events
  module Messaging
    class Producer
      include ::Helpers::Display

      ERROR_MESSAGES = [
        "ERR: Failed to connect to RabbitMQ Server!. Make sure RabbitMQ is running and properly configured.",
        "ERR: Events will *not* be published to StatsService."
      ].freeze

      def initialize
        connection = Bunny.new(ENV["RABBITMQ_URI"])
        connection.start

        @channel = connection.create_channel
        @exchange = @channel.topic("game_events")
      rescue Bunny::TCPConnectionFailed
        ERROR_MESSAGES.each { puts in_red _1 }
      end

      def emit_event(payload)
        return unless @exchange

        routing_key = routing_key_for(payload)
        serialized_payload = build_payload(payload)

        @exchange.publish(serialized_payload, routing_key: routing_key)
      end

      private

      def build_payload(payload)
        payload.merge!(
          timestamp: Time.now,
        ).to_json
      end

      def routing_key_for(payload)
        routing_key = case payload[:type].to_s
                      when /Planet/
                        "game_events.planets"
                      when /Ship/
                        "game_events.ships"
                      when /Shop/
                        "game_events.shops"
                      end

        routing_key
      end

    end
  end
end
