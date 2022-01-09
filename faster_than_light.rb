# Load helpers first:
Dir[File.join(__dir__, 'lib', 'helpers', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |file| require_relative file }
require 'pry'

module FasterThanLight
  print "Generating new galactic sector..."
  sector_graph = SectorGraph.new
  ship = Ship.new(sector_graph: sector_graph)
  puts "Done!"

  loop do
    ship.display_dashboard
    ship.event!
    ship.display_dashboard

    if ship.final_position? && !ship.empty_fuel? && !ship.destroyed?
      puts "Game Won!"
      break
    elsif ship.empty_fuel? || ship.destroyed? || ship.final_position?
      puts "Game lost! :-("
      break
    end

    input = Helpers::UserInput.display(
      phrase: "Move to next position?",
      choices: ["y", "quit"]
    )
    break if input == "quit"

    ship.move_ship_to_new_position!
  end

end
