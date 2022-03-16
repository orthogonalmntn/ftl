require 'sidekiq'
require_relative '../operations/db/db_client'

class StarPlagueWorker
  include Sidekiq::Job

  sidekiq_options retry: false

  def perform(simplified_graph_id)
    db_client = ::Db::DbClient.client
    graph_id = {:_id => BSON::ObjectId(simplified_graph_id)}
    graph = db_client[:graphs].find(graph_id)

    graph_size = graph.first.size
    puts "In a graph of size: #{graph_size}"
    random_spot_to_start = rand(graph_size)
    puts "Starting at #{random_spot_to_start} out of #{graph_size}..."

    going_up = random_spot_to_start
    going_down = random_spot_to_start

    loop do
      break if going_up < 0 && going_down == graph_size

      if going_up >= 0
        graph.update_one({"$set": { going_up.to_s => "infected"} })
        going_up -= 1
      end

      if going_down != graph_size
        graph.update_one({"$set": { going_down.to_s => "infected"} })
        going_down += 1
      end

      sleep 1
    end
  end

end
