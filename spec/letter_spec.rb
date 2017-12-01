require "spec_helper"
require_relative "../lib/letter"

describe Letter do
  describe "#to_s" do
    it "returns the class + name" do
      expect(described_class.new(:g).to_s).to eq("#<Letter G>")
    end
  end
end
