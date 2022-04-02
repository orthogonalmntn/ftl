require "./config/application"

module FasterThanLight
  size = 10
  width = 3

  puts <<-TEXT

       Faster Than Ruby-Refracted Light

       Game Version #{VERSION}

  TEXT

  generator = Generators::GradualMachineGenerator.new

  print "Generating new galactic sector of size #{size} and width #{width}..."

  graph = Graph::Graph.new(size, width, generator)
  total_graph_size = Graph::Node::class_variable_get(:@@id_incrementor)

  simplified_graph = Operations::StoreSimplifiedGraph.call(size: total_graph_size).inserted_id
  simplified_graph_id = simplified_graph.as_extended_json["$oid"]

  ship = Ship.new(sector_graph: graph, graph_id: simplified_graph_id)

  puts "Done!"

  print "Starting up background work..."

  StarPlagueWorker.perform_async(simplified_graph_id)

  puts "Done!"

  Game.new(ship).run!
end
