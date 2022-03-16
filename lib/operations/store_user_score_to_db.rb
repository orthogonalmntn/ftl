module Operations
  class StoreUserScoreToDb < Operation

    attribute :score
    attribute :at_time

    def call
      collection.insert_one(user_score)
    end

    private

    def user_score
      {
        score: score,
        created_at: at_time,
      }
    end

    def collection
      ::Db::DbClient.client[:user_scores]
    end

  end
end
