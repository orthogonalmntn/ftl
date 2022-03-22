require 'spec_helper'

describe Operations::StoreUserScoreToDb do
  subject { described_class.call(score: score, at_time: at_time) }

  after do
    Db::DbClient.client[:user_scores].delete_many({})
  end

  context "when passed a user score and time" do
    let(:score) { 0 }
    let(:at_time) { DateTime.now }
    
    it "stores the score to the database" do
      expect { subject }.to change { Db::DbClient.client[:user_scores].count }.by(1)
    end
  end
end
