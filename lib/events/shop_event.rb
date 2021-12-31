module FasterThanLight
  module Events
    class ShopEvent < BaseEvent

      def event_name
        "Shop Hedys"
      end

      def event_description
        "The best shop in the quadrant."
      end

      def perform_event_actions(ship:)
        event_action_text

        input = display(
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

      def event_action_text
        puts "You tank some fuel from the shop."
      end

    end
  end
end
