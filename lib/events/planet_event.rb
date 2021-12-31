module FasterThanLight
  module Events
    class PlanetEvent < BaseEvent

      def event_name
        "Planet ABC123X"
      end

      def event_description
        "A desolate planet without any signs of life. (?)"
      end

      def perform_event_actions(ship:)
        event_action_text

        input = display(
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

      private

      def event_action_text
        puts "You waste some fuel caught in the planet's gravity."
      end

    end
  end
end
