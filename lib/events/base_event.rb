module FasterThanLight
  module Events
    class BaseEvent

      include Helpers::Events,
        Helpers::UserInput,
        Helpers::Math

      def resolve_event!(ship:)
        emit_event_for(ship)

        puts "You have stumbled onto: #{name}\n#{description}"
        perform_event_actions(ship: ship)
      end

      def perform_event_actions
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      private

      def emit_event_for(ship)
        payload = {
            type: self.class,
            name: name,
            description: description,
          }

        ship.event_producer.emit_event(payload)
      end

    end
  end
end
