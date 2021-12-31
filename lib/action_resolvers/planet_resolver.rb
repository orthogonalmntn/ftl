module FasterThanLight
  module ActionResolvers
    class PlanetResolver < ActionResolver

      def call
        if event_details[:explore]
          fuel_loss = 2
          scrap_gain = random(3)
        else
          fuel_loss = 1
          scrap_gain = 0
        end

        ActionOutcome.new(fuel_loss: fuel_loss, scrap_gain: scrap_gain)
      end

    end
  end
end
