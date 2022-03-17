module Operations
  class FetchHighScores < Operation

    attribute :top

    def call
      fetch_top_results
    end

    private

    def fetch_top_results
      collection.find({}, { projection: { _id: 0 } }).sort(score: -1).limit(top).to_a
    end

    def collection
      ::Db::DbClient.client[:user_scores]
    end

  end
end
