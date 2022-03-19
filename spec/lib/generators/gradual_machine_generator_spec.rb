require 'spec_helper'

describe FasterThanLight::Generators::GradualMachineGenerator do
  context "when generating planets" do
    context "with placeholders" do
      subject { described_class.new.generate_planet }

      it "creates a new planet placeholder" do
        expect(subject).to be_a(String)
      end
    end

    context "with real planets" do
      subject do
        VCR.use_cassette("generate_planet") { described_class.new.generate_real_planet }
      end

      it "gets planet generated data from the generator service" do
        expect(subject).to be_an_instance_of(FasterThanLight::Events::PlanetEvent)

        expect(subject.name).to be_a(String)
        expect(subject.description).to be_a(String)
      end
    end
  end

  context "when generating shops" do
    context "with placeholders" do
      subject { described_class.new.generate_shop }

      it "creates a new planet placeholder" do
        expect(subject).to be_a(String)
      end
    end

    context "with real shops" do
      subject do
        VCR.use_cassette("generate_shop") { described_class.new.generate_real_shop }
      end

      it "gets shop generated data from the generator service" do
        expect(subject).to be_an_instance_of(FasterThanLight::Events::ShopEvent)

        expect(subject.name).to be_a(String)
        expect(subject.description).to be_a(String)
      end
    end
  end

  context "when generating ships" do
    context "with placeholders" do
      subject { described_class.new.generate_ship }

      it "creates a new ship placeholder" do
        expect(subject).to be_a(String)
      end
    end

    context "with real ships" do
      subject do
        VCR.use_cassette("generate_ship") { described_class.new.generate_real_ship }
      end

      it "gets ship generated data from the generator service" do
        expect(subject).to be_an_instance_of(FasterThanLight::Events::ShipEvent)

        expect(subject.name).to be_a(String)
        expect(subject.description).to be_a(String)
      end
    end
  end
end
