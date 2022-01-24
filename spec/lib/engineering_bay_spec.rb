require 'spec_helper'

describe FasterThanLight::EngineeringBay do
  context "when visiting Engineering Bay" do
    let(:is_max_level) { false }
    let(:level) { 1 }
    let(:engine) { double("Engine", type: :thruster, str: 1, :max_level? => is_max_level, level: level) }
    let(:weapon) { double("Weapon", type: :torpedo, str: 1, :max_level? => is_max_level, level: level) }
    let(:ship) { double("Ship", scrap: scrap, engine: engine, weapon: weapon) }
    let(:engineering_bay) { described_class.new(ship) }

    subject do
      engineering_bay.visit!
    end

    context "when upgrading engines" do
      before do
        allow_any_instance_of(described_class).to receive(:gets).and_return("E")
        allow(engine).to receive(:upgrade!)
      end

      context "with enough scrap" do
        let(:scrap) { 20 }

        it "upgrades engines" do
          subject
          expect(engine).to have_received(:upgrade!)
        end

        it "returns a ship handler object" do
        end
      end

      context "without scrap" do
        let(:scrap) { 1 }

        it "warns of no scrap" do
          expect { subject }.to output(/Not enough scrap/).to_stdout
        end

        it "doesn't upgrade engine" do
          subject
          expect(engine).not_to have_received(:upgrade!)
        end
      end
    end

    context "when upgrading weapons" do
      before do 
        allow_any_instance_of(described_class).to receive(:gets).and_return("W")
        allow(weapon).to receive(:upgrade!)
      end

      context "with enough scrap" do
        let(:scrap) { 20 }

        it "upgrades weapons" do
          subject
          expect(weapon).to have_received(:upgrade!)
        end

        it "returns a ship handler object" do
        end
      end

      context "without enough scrap" do
        let(:scrap) { 1 }

        it "doesn't upgrade weapons" do
          expect { subject }.to output(/Not enough scrap/).to_stdout
        end
        
        it "doesn't upgrade weapons" do
          subject
          expect(weapon).not_to have_received(:upgrade!)
        end
      end
    end
  end
end
