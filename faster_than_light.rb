# Load helpers first:
Dir[File.join(__dir__, 'lib', 'helpers', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |file| require_relative file }
require 'pry'

module FasterThanLight
  size = 10
  width = 3

  print "Generating new galactic sector of size #{size} and width #{width}..."
  graph = Graph::Graph.new(size, width)
  ship = Ship.new(sector_graph: graph)
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
      phrase: "Which position to move to [1, 2, 3]?",
      choices: ["1", "2", "3", "quit"]
    )
    break if input == "quit"

    ship.move_ship_to_new_position!(input.to_i)
  end

end
