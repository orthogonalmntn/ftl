require 'pry'
require 'dotenv/load'
Dir[File.join(__dir__, 'lib', 'helpers', '*.rb')].each { |file| require_relative file }

require_relative 'lib/operations/operation'
Dir[File.join(__dir__, 'lib', 'operations', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'lib', 'events', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |file| require_relative file }

module FasterThanLight
  size = 10
  width = 3

  # TODO: Let user pick which Generator to use.
  generator = Generators::GradualMachineGenerator.new

  print "Generating new galactic sector of size #{size} and width #{width}..."
  graph = Graph::Graph.new(size, width, generator)
  ship = Ship.new(sector_graph: graph)
  puts "Done!"

  Game.new(ship).run!
end
