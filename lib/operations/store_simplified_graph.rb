require 'mongo'

module Operations
  class StoreSimplifiedGraph < Operation

    attribute :size

    DB_URL = ENV["MONGODB_URL"]
    DB_NAME = ENV["MONGODB_NAME"]

    def call
      store_to_db simplified_graph
    end

    private

    def store_to_db(graph)
      db_client[:graphs].insert_one(graph)
    end

    def simplified_graph
      # number of nodes in tree: (width^(size-1))/(width-1)
      # total_nodes = (width ** (size - 1)) / (width - 1)
      simplified_graph = {}
      size.times { |num| simplified_graph[num] = 0 }
      simplified_graph
    end

    def db_client
      Mongo::Client.new([ DB_URL ], :database => DB_NAME)
    end

  end
end
