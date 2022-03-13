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

  generator = Generators::GradualMachineGenerator.new

  print "Generating new galactic sector of size #{size} and width #{width}..."

  graph = Graph::Graph.new(size, width, generator)
  total_graph_size = Graph::Node::class_variable_get(:@@id_incrementor)

  simplified_graph = Operations::StoreSimplifiedGraph.call(size: total_graph_size).inserted_id
  simplified_graph_id = simplified_graph.as_extended_json["$oid"]

  ship = Ship.new(sector_graph: graph, graph_id: simplified_graph_id)

  puts "Done!"

  puts "Starting up background work..."

  StarPlagueWorker.perform_async(simplified_graph_id)

  puts "Done!"

  Game.new(ship).run!
end
