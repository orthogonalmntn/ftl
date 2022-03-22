require 'spec_helper'

describe Operations::StoreSimplifiedGraph do
  subject { described_class.call(size: size) }

  after do
    Db::DbClient.client[:graphs].delete_many({})
  end

  context "when passed a size" do
    let(:size) { 10 }
    
    it "stores a simplified graph to the database" do
      expect { subject }.to change { Db::DbClient.client[:graphs].count }.by(1)
    end
  end
end
