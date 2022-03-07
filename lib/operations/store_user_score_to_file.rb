module Operations
  class StoreUserScoreToFile < Operation

    FILE_NAME = "scores.out"

    attribute :score

    def call
      File.open(FILE_NAME, "a") do |file|
        file << "SCORE: #{score}\tTIME: #{Time.now}\n"
      end
    end

  end
end
