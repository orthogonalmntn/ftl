require "bunny"
require "json"

module Events
  module Messaging
    class Producer

      def initialize
        connection = Bunny.new
        connection.start

        @channel = connection.create_channel
        @queue = @channel.queue("game_events")
      end

      def emit_event(payload)
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
