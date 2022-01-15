module FasterThanLight
  module Events
    class ShopEvent < BaseEvent

      attr_reader :name, :description

      def initialize
        @name = generate_name
        @description = generate_description
      end

      def perform_event_actions(ship:)
        input = get_input(
          phrase: "Buy fuel or leave?",
          choices: ["B", "L"],
        )

        outcome = case input
                  when "B"
                    ActionResolvers::ShopResolver.call(ship: ship, event: self, event_details: { purchase: true })
                  when "L"
                    ActionResolvers::ShopResolver.call(ship: ship, event: self, event_details: { purchase: false })
                  end

        EventResponse.new(fuel_gain: outcome.fuel_gain, scrap_loss: outcome.scrap_loss)
      end

      private

      def generate_name
        names = [
          'Hedys Shop',
          'Tin X',
          'Veeropulos'
        ]

        names[rand(names.length)]
      end

      def generate_description
        descriptions = [
          'A small shop with not much in the way of exotic merchandise',
          'Big, expensive shop',
          'The only shop in this sector'
        ]

        descriptions[rand(descriptions.length)]
      end

    end
  end
end
