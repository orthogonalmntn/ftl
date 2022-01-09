module FasterThanLight
  module Events
    class ShipEvent < BaseEvent

      attr_reader :name, :description, :torpedos, :health

      def initialize
        @name = "Enemy Frigate Zebulon"
        @description = "A strong and sturdy ship made out of carbon composite."
        @torpedos = 1
        @health = 3
      end

      def perform_event_actions(ship:)
        event_action_text

        input = display(
          phrase: "Fight or avoid?",
          choices: ["F", "A"],
        )

        outcome = case input
                  when "F"
                    ActionResolvers::CombatResolver.call(ship: ship, event: self)
                  when "A"
                    ActionResolvers::AvoidanceResolver.call(ship: ship, event: self)
                  end

        EventResponse.new(ship_damage: outcome.ship_damage, fuel_loss: outcome.fuel_loss, scrap_gain: outcome.scrap_gain)
      end

      private

      def event_action_text
        puts "The ship causes some damage to your ship, and a hole makes you leak some fuel."
      end

    end
  end
end