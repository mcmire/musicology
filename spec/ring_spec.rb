require "spec_helper"
require_relative "../lib/ring"

describe Ring do
  describe "#at" do
    it "returns the wrapped object that matches the given index" do
      ring = described_class.new(TestRingItemWrapper, ["a", "b"])

      wrapped_ring_item = ring[1]

      expect(wrapped_ring_item).to be_a(TestRingItemWrapper)
      expect(wrapped_ring_item).to eq("b")
      expect(wrapped_ring_item.index).to be(1)
    end
  end

  describe "#[]" do
    context "given a value" do
      it "returns the wrapped object that matches that value" do
        ring = described_class.new(TestRingItemWrapper, ["a", "b"])

        expect(ring["b"]).to have_attributes(value: "b", index: 1)
      end
    end

    context "given an index" do
      it "returns the wrapped object that matches that index" do
        ring = described_class.new(TestRingItemWrapper, ["a", "b"])

        expect(ring[1]).to have_attributes(value: "b", index: 1)
      end
    end

    context "given the wrapped object" do
      it "returns the wrapped object itself" do
        ring = described_class.new(TestRingItemWrapper, ["a", "b"])
        ring_item = ring["b"]

        expect(ring[ring_item]).to be(ring_item)
      end
    end
  end
end
