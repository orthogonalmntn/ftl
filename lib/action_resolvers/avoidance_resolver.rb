module FasterThanLight
  module ActionResolvers
    class AvoidanceResolver < ActionResolver

      def call
        ship_damage, fuel_loss = ship_engine_against_event_engine
        show_outcome_of_avoidance(ship_damage, fuel_loss)

        ActionOutcome.new(ship_damage: ship_damage, fuel_loss: fuel_loss)
      end

      private

      def ship_engine_against_event_engine
        ship_damage = 0
        fuel_loss = 1

        unless ship_has_evaded?
          ship_damage = random(3)
          fuel_loss = random(3)
        end

        return [ship_damage, fuel_loss]
      end

      def ship_has_evaded?
        evastion_roll = ship.engine.str > event.engine.str ? random(3) : random(10)

        if evastion_roll == 1
          puts "You have managed to avoid the enemy ship."
          return true
        else
          puts "You haven't avoided the enemy ship!"
          return false
        end
      end

      def show_outcome_of_avoidance(ship_damage, fuel_loss)
        puts "Damage gotten: #{ship_damage}"
        puts "Fuel lost: #{fuel_loss}"
      end

    end
  end
end

