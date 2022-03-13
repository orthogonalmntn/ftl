require 'mongo'

module Operations
  class CheckInfectedNodes < Operation

    attribute :graph_id
    attribute :node_ids

    DB_URL = ENV["MONGODB_URL"]
    DB_NAME = ENV["MONGODB_NAME"]

    def call
      gid = { :_id => BSON::ObjectId(graph_id) }
      graph = db_client[:graphs].find(gid).first
      node_ids.map(&:to_s).select { |node| graph[node] == "infected" }.map(&:to_i)
    end

    private

    def db_client
      Mongo::Client.new([ DB_URL ], :database => DB_NAME)
    end

  end
end
