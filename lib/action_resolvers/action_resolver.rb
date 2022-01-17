module FasterThanLight
  module ActionResolvers
    class ActionResolver

      include Helpers::Math,
        Helpers::Display

      attr_reader :ship, :event, :event_details

      ACTION_OUTCOME_KEYS = [
        :ship_damage,
        :fuel_loss,
        :fuel_gain,
        :scrap_loss,
        :scrap_gain,
        :health_gain,
      ]

      ActionOutcome = Struct.new(:success?, *ACTION_OUTCOME_KEYS, keyword_init: true)

      def initialize(ship:, event:, event_details: nil)
        @ship = ship
        @event = event
        @event_details = event_details
      end

      def self.call(...)
        self.new(...).call
      end

    end
  end
end

