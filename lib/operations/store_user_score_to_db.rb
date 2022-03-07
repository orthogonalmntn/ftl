require 'mongo'

module Operations
  class StoreUserScoreToDb < Operation

    attribute :score

    DB_URL = ENV["MONGODB_URL"]
    DB_NAME = ENV["MONGODB_NAME"]

    def call
      collection.insert_one(user_score)
    end

    private

    def user_score
      {
        score: score,
        created_at: Time.now,
      }
    end

    def collection
      db_client[:user_scores]
    end

    def db_client
      Mongo::Client.new([ DB_URL ], :database => DB_NAME)
    end

  end
end
