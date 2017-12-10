require "spec_helper"
require_relative "../../lib/musicology/letter"

describe Musicology::Letter do
  describe "#to_s" do
    it "returns the class + name" do
      expect(described_class.new(:g).to_s).to eq("#<Musicology::Letter G>")
    end
  end
end
