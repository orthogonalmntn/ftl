module FasterThanLight
  module ActionResolvers
    class PlanetResolver < ActionResolver

      def call
        if event_details[:explore]
          puts in_blue "The planet has a gravity field of strength #{event.gravity_str}"

          if ship.engine.str > event.gravity_str
            fuel_loss = rand(1)
          else
            fuel_loss = random(3)
          end
          scrap_gain = random(3)
        else
          fuel_loss = 1
          scrap_gain = 0
        end

        puts "You have lost #{in_red fuel_loss} fuel, and gained #{in_green scrap_gain} scrap."
        ActionOutcome.new(fuel_loss: fuel_loss, scrap_gain: scrap_gain)
      end

    end
  end
end
