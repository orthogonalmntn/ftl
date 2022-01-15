module FasterThanLight
  module ActionResolvers
    class ShopResolver < ActionResolver

      def call
        if event_details[:purchase] && ship.scrap > 0
          # TODO: add more items to purchase
          fuel_gain = 1
          scrap_loss = 1
        else
          fuel_gain = 0
          scrap_loss = 0
        end

        puts "You have bought #{in_green fuel_gain} fuel, and lost #{in_red scrap_loss} scrap."
        ActionOutcome.new(fuel_gain: fuel_gain, scrap_loss: scrap_loss)
      end

    end
  end
end
