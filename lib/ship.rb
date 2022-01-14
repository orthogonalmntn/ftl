module FasterThanLight
  class Ship

    attr_reader :fuel, :health, :scrap, :weapon, :engine

    def initialize(sector_graph:)
      @fuel = 10
      @health = 10
      @scrap = 10
      @weapon = Components::Weapon.new(weapon_type: "Torpedo", weapon_str: 3)
      @engine = Components::Engine.new(engine_type: "Nuclear", engine_str: 5)
      @current_node = sector_graph.start_node
    end

    def move_ship_to_new_position!(input)
      return if final_position?

      @current_node = @current_node.nodes[(input - 1)]
      @fuel -= 1
    end

    def event!
      if event = @current_node.event
        event_response = event.resolve_event!(ship: self)
        handle_event_response(event_response)
      else
        puts "There seems to be nothing here."
      end
    end

    def display_dashboard
      puts "[---------------------------------]"
      puts "CURRENT POSITION: #{@current_node.position}"
      puts "FUEL: #{fuel} / HEALTH: #{health} / SCRAP: #{scrap}"
      puts "[---------------------------------]"
    end

    def final_position?
      @current_node.last?
    end

    def empty_fuel?
      @fuel <= 0
    end

    def destroyed?
      @health <= 0
    end

    private

    def handle_event_response(event_response)
      # Fuel
      @fuel += event_response.fuel_gain if event_response.fuel_gain
      @fuel -= event_response.fuel_loss if event_response.fuel_loss

      # Scrap
      @scrap += event_response.scrap_gain if event_response.scrap_gain
      @scrap -= event_response.scrap_loss if event_response.scrap_loss

      # Health
      @health -= event_response.ship_damage if event_response.ship_damage
    end

  end
end
