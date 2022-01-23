require 'spec_helper'

describe FasterThanLight::Components::Weapon do
  context "when creating weapons" do
    subject { described_class.new(weapon_level: weapon_level) }

    context "with allowed types" do
      let(:weapon_level) { 1 }

      it "creates a new weapon of desired type" do
        expect(subject).to be_an_instance_of(FasterThanLight::Components::Weapon)
      end
    end

    context "when trying to create an weapon of non-existant level" do
      let(:weapon_level) { :banana }

      it "raises an error" do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end

  context "when upgrading weapons" do
    context "when upgradeable" do
      let(:initial_weapon_level) { :torpedo }
      let(:upgraded_weapon_type) { :nuclear }

      let!(:current_weapon) { described_class.new }

      it "upgrades to weapon of one level up" do
        expect { current_weapon.upgrade! }.to change { current_weapon.type }.from(initial_weapon_level).to(upgraded_weapon_type)
      end
    end

    context "when already at max level" do
      let(:initial_weapon_level) { :dark_energy }

      let!(:current_weapon) { described_class.new(weapon_level: 5) }

      it "doesn't change the maximum weapon level" do
        expect { current_weapon.upgrade! }.not_to change { current_weapon.type }.from(initial_weapon_level)
      end
    end
  end
end
