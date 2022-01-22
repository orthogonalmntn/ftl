module FasterThanLight
  module Events
    class PlanetEvent < BaseEvent

      attr_reader :name, :description, :gravity_str

      def initialize(name, description)
        @name = name
        @description = description
        @gravity_str = random(7)
      end

      def perform_event_actions(ship:)
        input = get_input(
          phrase: "Explore or avoid?",
          choices: ["E", "A"],
        )

        outcome = case input
                  when "E"
                    ActionResolvers::PlanetResolver.call(ship: ship, event: self, event_details: { explore: true })
                  when "A"
                    ActionResolvers::PlanetResolver.call(ship: ship, event: self, event_details: { explore: false })
                  end

        EventResponse.new(fuel_loss: outcome.fuel_loss, scrap_gain: outcome.scrap_gain)
      end

    end
  end
end
