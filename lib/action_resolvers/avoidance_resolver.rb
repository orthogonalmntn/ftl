module FasterThanLight
  module ActionResolvers
    class AvoidanceResolver < ActionResolver

      def call
        # Resolve based on Ship's Engine vs. Event's Engine.
        ActionOutcome.new(ship_damage: 1, fuel_loss: 1)
      end

    end
  end
end

