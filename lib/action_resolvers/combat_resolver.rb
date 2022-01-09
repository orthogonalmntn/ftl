module FasterThanLight
  module ActionResolvers
    class CombatResolver < ActionResolver

      CombatStats = Struct.new(
        :ship_damage,
        :event_damage,
        :fuel_loss,
        :scrap_gain,
        keyword_init: true
      )

      def call
        combat_stats = ship_weapons_against_event_weapons
        show_outcome_of_combat(combat_stats)

        ActionOutcome.new(
          ship_damage: combat_stats.ship_damage,
          fuel_loss: combat_stats.fuel_loss,
          scrap_gain: combat_stats.scrap_gain
        )
      end

      private

      def ship_weapons_against_event_weapons
        dmg_to_event = 0
        dmg_to_ship = 0

        loop do
          # you strike first:
          dmg_to_event += (ship.weapon.str * random(5)) / random(3)
          break if dmg_to_event > event.health

          dmg_to_ship += (event.weapon.str * random(3)) / random(3)
        end

        scrap_gain = dmg_to_event.floor
        fuel_loss_to_ship = dmg_to_ship * 0.5

        CombatStats.new(
          ship_damage: dmg_to_ship,
          event_damage: dmg_to_event,
          fuel_loss: fuel_loss_to_ship,
          scrap_gain: scrap_gain,
        )
      end

      def show_outcome_of_combat(combat_stats)
        puts "------------------------"
        puts "In combat with #{event.name} / T: #{event.weapon.str} H: #{event.health}"
        puts "You deal: #{combat_stats.event_damage}"
        puts "Damage gotten: #{combat_stats.ship_damage}"
        puts "Fuel lost: #{combat_stats.fuel_loss}"
        puts "Scrap gained: #{combat_stats.scrap_gain}"
        puts "------------------------"
      end

    end
  end
end
