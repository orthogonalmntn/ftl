require 'spec_helper'

describe FasterThanLight::Components::Engine do
  context "when creating engines" do
    subject { described_class.new(engine_level: engine_level) }

    context "with allowed types" do
      let(:engine_level) { 1 }

      it "creates a new engine of desired type" do
        expect(subject).to be_an_instance_of(FasterThanLight::Components::Engine)
      end
    end

    context "when trying to create an engine of non-existant level" do
      let(:engine_level) { :banana }

      it "raises an error" do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end

  context "when upgrading engines" do
    context "when upgradeable" do
      let(:initial_engine_level) { :thruster }
      let(:upgraded_engine_type) { :nuclear }

      let!(:current_engine) { described_class.new }

      it "upgrades to engine of one level up" do
        expect { current_engine.upgrade! }.to change { current_engine.type }.from(initial_engine_level).to(upgraded_engine_type)
      end
    end

    context "when already at max level" do
      let(:initial_engine_level) { :dark_matter }

      let!(:current_engine) { described_class.new(engine_level: 5) }

      it "doesn't change the maximum engine level" do
        expect { current_engine.upgrade! }.not_to change { current_engine.type }.from(initial_engine_level)
      end
    end
  end
end
