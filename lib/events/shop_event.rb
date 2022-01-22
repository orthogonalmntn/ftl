module FasterThanLight
  module Events
    class ShopEvent < BaseEvent

      attr_reader :name, :description

      def initialize(name, description)
        @name = name
        @description = description
      end

      def perform_event_actions(ship:)
        loop do
          input = get_input(
            phrase: "Buy fuel, repair ship, or leave?",
            choices: ["B", "R", "L"],
          )

          outcome = case input
                    when "B"
                      ActionResolvers::ShopResolver.call(ship: ship, event: self, event_details: { purchase: :fuel })
                    when "R"
                      ActionResolvers::ShopResolver.call(ship: ship, event: self, event_details: { purchase: :repair })
                    when "L"
                      return
                    end

          if outcome.success?
            return EventResponse.new(fuel_gain: outcome.fuel_gain, health_gain: outcome.health_gain, scrap_loss: outcome.scrap_loss)
          else
            puts "You are unable to complete this action"
          end
        end
      end

    end
  end
end
