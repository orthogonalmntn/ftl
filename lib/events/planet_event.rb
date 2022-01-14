module FasterThanLight
  module Events
    class PlanetEvent < BaseEvent

      attr_reader :name, :description, :gravity_str

      def initialize
        @name = generate_name
        @description = generate_description
        @gravity_str = random(7)
      end

      def perform_event_actions(ship:)
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

      def generate_name
        names = [
          'Planet X',
          'Planet Y',
          'Planet Z'
        ]

        names[rand(names.length)]
      end

      def generate_description
        descriptions = [
          'A dry planet with no signs of life',
          'An ocean planet with shiny sun-streaks on its massive waves',
          'Rocky world, with scattered signs of primitive civilization'
        ]

        descriptions[rand(descriptions.length)]
      end

    end
  end
end
