module FasterThanLight
  module ActionResolvers
    class PlanetResolver < ActionResolver

      def call
        if event_details[:explore]
          fuel_loss = 2 # can be calculated based on Planet's Gravity
          scrap_gain = random(3)
        else
          fuel_loss = 1
          scrap_gain = 0
        end

        puts "You have lost #{fuel_loss} fuel, and gained #{scrap_gain} scrap."
        ActionOutcome.new(fuel_loss: fuel_loss, scrap_gain: scrap_gain)
      end

    end
  end
end
