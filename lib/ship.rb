module FasterThanLight
  class Ship

    attr_reader :fuel, :position, :health, :scrap, :torpedos

    NO_EVENT_MESSAGE = "There seems to be nothing here."

    def initialize(sector_graph: SectorGraph.new)
      @fuel = 10
      @health = 10
      @scrap = 10
      @torpedos = 3
      @sector_graph = sector_graph.graph
      @position = sector_graph.graph.keys.first
    end

    def move_ship_to_new_position!
      return if final_position?

      @position = @sector_graph.keys[@position + 1]
      @fuel -= 1
    end

    def event!
      if event = @sector_graph[@position]
        event_response = event.resolve_event!(ship: self)
        handle_event_response(event_response)
      else
        puts NO_EVENT_MESSAGE
      end
    end

    def display_dashboard
      puts "[---------------------------------]"
      puts "CURRENT POSITION: #{position}"
      puts "FUEL: #{fuel} / HEALTH: #{health} / SCRAP: #{scrap}"
      puts "[---------------------------------]"
    end

    def final_position?
      @position == @sector_graph.keys.last
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
