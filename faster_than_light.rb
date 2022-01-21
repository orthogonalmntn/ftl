Dir[File.join(__dir__, 'lib', 'helpers', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'lib', 'events', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |file| require_relative file }
require 'pry'

module FasterThanLight
  size = 10
  width = 3

  print "Generating new galactic sector of size #{size} and width #{width}..."
  graph = Graph::Graph.new(size, width)
  ship = Ship.new(sector_graph: graph)
  puts "Done!"

  Game.new(ship).run!
end
