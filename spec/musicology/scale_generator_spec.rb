require "spec_helper"
require_relative "../../lib/musicology/generate_modal_families"

describe Musicology::GenerateModalFamilies do
  it "returns a bunch of modal families" do
    modal_families = described_class.call

    expect(modal_families.size).to eq(288)

    modal_family = modal_families.detect do |modal_family|
      modal_family.scales.detect { |scale| scale.word == 2741 }
    end
    expect(modal_family.scales.size).to eq(7)
    scale = modal_family.scales.detect { |scale| scale.word == 2741 }
    expect(scale.notes.map(&:name)).to eq(["C", "D", "E", "F", "G", "A", "B"])
  end
end
