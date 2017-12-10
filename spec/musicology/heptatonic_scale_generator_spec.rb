require "spec_helper"
require_relative "../../lib/musicology/heptatonic_scale_generator"

describe Musicology::HeptatonicScaleGenerator do
  it "returns a random heptatonic scale" do
    scale = described_class.call

    expect(scale.notes.size).to be(7)
  end
end
