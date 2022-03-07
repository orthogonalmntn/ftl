require 'mongo'

module Operations
  class FetchHighScores < Operation

    attribute :top

    DB_URL = ENV["MONGODB_URL"]
    DB_NAME = ENV["MONGODB_NAME"]

    def call
      fetch_top_results
    end

    private

    def fetch_top_results
      collection.find({}, { projection: { _id: 0 } }).sort(score: -1).limit(top).to_a
    end

    def collection
      db_client[:user_scores]
    end

    def db_client
      Mongo::Client.new([ DB_URL ], :database => DB_NAME)
    end

  end
end
