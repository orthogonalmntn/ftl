module FasterThanLight
  module Events
    class BaseEvent

      include Helpers::UserInput

      EVENT_ACTION_KEYS = [
        :fuel_gain,
        :fuel_loss,
        :ship_damage,
        :scrap_gain,
        :scrap_loss,
      ]

      EventResponse = Struct.new(*EVENT_ACTION_KEYS, :action_resolver, keyword_init: true)

      def resolve_event!(ship:)
        puts "You have stumbled onto: #{name}\n#{description}"
        perform_event_actions(ship: ship)
      end

      def perform_event_actions
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

    end
  end
end
