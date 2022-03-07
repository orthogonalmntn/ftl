require 'mongo'

module Operations
  class ShowHighScores < Operation

    attribute :top

    DB_URL = ENV["MONGODB_URL"]
    DB_NAME = ENV["MONGODB_NAME"]

    def call
      results = fetch_top_results
      display results
    end

    private

    def display(results)
      puts "HIGH SCORES:"
      results.each do |res|
        puts "#{res["score"]} | #{res["created_at"]}"
      end
    end

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
