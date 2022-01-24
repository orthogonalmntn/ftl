module FasterThanLight
  class Game

    include Helpers::UserInput,
      Helpers::Display

    def initialize(ship)
      @ship = ship
      @map = Map.new
      @engineering_bay = EngineeringBay.new(@ship)
      @score = 0
    end

    def run!
      display_dashboard

      # main game loop
      loop do
        @ship.event!
        display_dashboard

        if game_result_check = game_over?
          puts game_result_check
          puts "Your score is: #{in_green calculated_user_score}"
          break
        end

        @map.display_map(@ship.position)

        input = get_user_input
        break if input == -1

        if input == "E"
          action_outcome = @engineering_bay.visit!
          @ship.handle_outcome(action_outcome)
          next
        end

        @map.add_next_node(@ship.position, input)
        @ship.move_ship_to_new_position!(input)
        @score += 10
      end
    end

    private

    def game_over?
      if @ship.final_position? && !@ship.empty_fuel? && !@ship.destroyed?
        return in_green "Game won!"
      elsif @ship.empty_fuel? || @ship.destroyed? || @ship.final_position?
        return in_red "Game over! :-("
      end

      return false
    end

    def get_user_input
      input = get_input(
        phrase: "Which position to move to [1, 2, 3, 0 (Go Back), E (Engineering)]?",
        choices: ["0", "1", "2", "3", "E", "quit"]
      )
      return -1 if input == "quit"
      return "E" if input == "E"

      input.to_i
    end

    def display_dashboard
      wrap_with_chars do
        puts in_light_blue "CURRENT POSITION: #{@ship.position}"
        print "FUEL: #{based_on_amount @ship.fuel} / "
        print "HEALTH: #{based_on_amount @ship.health} / "
        puts "SCRAP: #{based_on_amount @ship.scrap}"
      end
    end

    def calculated_user_score
      @score + 
        (@ship.scrap * 0.8) +
        (@ship.fuel > 0 ? @ship.fuel * 2 : 0) +
        (@ship.health > 0 ? @ship.health * 2 : 0)
    end

  end
end