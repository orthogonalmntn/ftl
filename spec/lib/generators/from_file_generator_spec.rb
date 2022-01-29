require 'spec_helper'

describe FasterThanLight::Generators::FromFileGenerator do
  context "when generating planets" do
    subject { described_class.new.generate_planet }

    it "creates a new planet event" do
      expect(subject).to be_an_instance_of(FasterThanLight::Events::PlanetEvent)
    end

    it "generates a planet name" do
      expect(subject.name).to be_a(String)
    end
    
    it "generates a planet description" do
      expect(subject.description).to be_a(String)
    end
  end

  context "when generating shops" do
    subject { described_class.new.generate_shop }

    it "creates a new shop event" do
      expect(subject).to be_an_instance_of(FasterThanLight::Events::ShopEvent)
    end

    it "generates a shop name" do
      expect(subject.name).to be_a(String)
    end
    
    it "generates a shop description" do
      expect(subject.description).to be_a(String)
    end
  end

  context "when generating ships" do
    subject { described_class.new.generate_ship }

    it "creates a new ship event" do
      expect(subject).to be_an_instance_of(FasterThanLight::Events::ShipEvent)
    end

    it "generates a ship name" do
      expect(subject.name).to be_a(String)
    end
    
    it "generates a ship description" do
      expect(subject.description).to be_a(String)
    end
  end
end
