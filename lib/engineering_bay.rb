module FasterThanLight
  class EngineeringBay

    include Helpers::UserInput,
      Helpers::Display,
      Helpers::Events

    def initialize(ship)
      @ship = ship
    end

    def visit!
      display_engineering_bay_panel

      input = get_input(
        phrase: "Upgrade [E]ngines / Upgrade [W]eapons / [L]eave Bay",
        choices: ["E", "W", "L"]
      )
      case input
      when "L"
        return
      when "E"
        upgrade_engines
      when "W"
        upgrade_weapons
      end
    end

    private
    
    def display_engineering_bay_panel
      wrap_with_chars do
        puts in_light_blue "ENGINEERING BAY"
        puts "SHIP ENGINES: #{@ship.engine.type.capitalize} / #{@ship.engine.str}\t| To upgrade: #{scrap_to_upgrade_engine}"
        puts "SHIP WEAPONS: #{@ship.weapon.type.capitalize} / #{@ship.weapon.str}\t| To upgrade: #{scrap_to_upgrade_weapon}"
      end
    end

    def upgrade_engines
      scrap_needed = scrap_to_upgrade_engine
      return if scrap_needed.is_a?(String)

      if @ship.scrap < scrap_needed
        puts in_red "Not enough scrap (#{scrap_needed}) for upgrade"
      else
        unless @ship.engine.max_level?
          @ship.engine.upgrade!
          return EventResponse.new(scrap_loss: scrap_needed)
        end
      end
    end

    def upgrade_weapons
      scrap_needed = scrap_to_upgrade_weapon
      return if scrap_needed.is_a?(String)

      if @ship.scrap < scrap_needed
        puts in_red "Not enough scrap (#{scrap_needed}) for upgrade"
      else
        unless @ship.engine.max_level?
          @ship.weapon.upgrade!
          return EventResponse.new(scrap_loss: scrap_needed)
        end
      end
    end

    def scrap_to_upgrade_engine
      return in_red "[MAX LEVEL ALREADY]" if @ship.engine.max_level?

      20 * @ship.engine.level
    end

    def scrap_to_upgrade_weapon
      return in_red "[MAX LEVEL ALREADY]" if @ship.weapon.max_level?

      20 * @ship.weapon.level
    end

  end
end
