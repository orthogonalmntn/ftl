module Operations
  class CheckInfectedNodes < Operation

    attribute :graph_id
    attribute :node_ids

    def call
      gid = { :_id => BSON::ObjectId(graph_id) }
      graph = ::Db::DbClient.client[:graphs].find(gid).first
      node_ids.map(&:to_s).select { |node| graph[node] == "infected" }.map(&:to_i)
    end

  end
end
