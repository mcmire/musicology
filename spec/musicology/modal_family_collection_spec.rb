require "spec_helper"
require_relative "../../lib/musicology/modal_family_collection"

describe Musicology::ModalFamilyCollection do
  describe "#all" do
    it "returns all known modal families" do
      collection = described_class.new
      major_scale = 2741

      modal_families = collection.all

      expect(modal_families.size).to eq(288)
      modal_family = modal_families.detect do |mf|
        mf.scales.detect { |scale| scale.word == major_scale }
      end
      expect(modal_family.scales.size).to eq(7)
      scale = modal_family.scales.detect { |s| s.word == major_scale }
      expect(scale.notes.map(&:name)).to eq(["C", "D", "E", "F", "G", "A", "B"])
    end
  end

  describe "#popular" do
    it "returns popular modal families" do
      collection = described_class.new

      modal_families = collection.popular

      expect(modal_families.size).to eq(19)
    end
  end
end
