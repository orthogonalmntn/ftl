module FasterThanLight
  module ActionResolvers
    class ShopResolver < ActionResolver

      def call
        case event_details[:purchase]
        when :fuel
          return ActionOutcome.new(success?: false) unless ship.scrap > 3

          fuel_gain = 1
          scrap_loss = 3
        when :repair
          return ActionOutcome.new(success?: false) unless ship.scrap > 3 && ship.health <= 9

          health_gain = ship.health < 9 ? 2 : 1
          scrap_loss = 3
        end

        puts "You have bought #{in_green fuel_gain} fuel, and lost #{in_red scrap_loss} scrap."
        ActionOutcome.new(success?: true, fuel_gain: fuel_gain, health_gain: health_gain, scrap_loss: scrap_loss)
      end

    end
  end
end
