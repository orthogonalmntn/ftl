module FasterThanLight
  class EngineeringBay

    include Helpers::UserInput,
      Helpers::Display

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
        puts "SHIP ENGINES: #{@ship.engine.type.capitalize} / #{@ship.engine.str}"
        puts "SHIP WEAPONS: #{@ship.weapon.type.capitalize} / #{@ship.weapon.str}"
      end
    end

    def upgrade_engines
      scrap_needed = 20 # increase cost with level

      if @ship.scrap < scrap_needed
        puts "Not enough scrap (#{scrap_needed}) for upgrade"
      else
        # deduct scrap from ship
        @ship.engine.upgrade!
      end
    end

    def upgrade_weapons
      scrap_needed = 20 # increase cost with level

      if @ship.scrap < scrap_needed
        puts "Not enough scrap"
      else
        # deduct scrap from ship
        # implement weapon upgrade
        @ship.weapon.upgrade!
      end
    end

  end
end
