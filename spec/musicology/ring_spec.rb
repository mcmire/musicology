require "spec_helper"
require_relative "../../lib/musicology/ring"

describe Musicology::Ring do
  describe "#at" do
    it "returns the wrapped object that matches the given index" do
      ring = described_class.new(TestRingItemWrapper, ["a", "b"])

      wrapped_ring_item = ring.find!(1)

      expect(wrapped_ring_item).to be_a(TestRingItemWrapper)
      expect(wrapped_ring_item).to eq("b")
      expect(wrapped_ring_item.index).to be(1)
    end
  end

  describe "#find!" do
    context "given a value" do
      it "returns the wrapped object that matches that value" do
        ring = described_class.new(TestRingItemWrapper, ["a", "b"])

        expect(ring.find!("b")).to have_attributes(value: "b", index: 1)
      end
    end

    context "given an index" do
      it "returns the wrapped object that matches that index" do
        ring = described_class.new(TestRingItemWrapper, ["a", "b"])

        expect(ring.find!(1)).to have_attributes(value: "b", index: 1)
      end
    end

    context "given an instance of the wrapped class obtained from the same ring" do
      it "returns that instance" do
        ring = described_class.new(TestRingItemWrapper, ["a", "b"])
        ring_item = ring.find!("b")

        expect(ring.find!(ring_item)).to be(ring_item)
      end
    end

    context "given an instance of the wrapped class obtained from a different ring" do
      it "returns the wrapped object itself" do
        ring1 = described_class.new(TestRingItemWrapper, ["some value"])
        ring_item1 = ring1.find!("some value")
        ring2 = described_class.new(TestRingItemWrapper, ["some value"])
        ring_item2 = ring2.find!("some value")

        found_ring_item = ring2.find!(ring_item1)

        expect(found_ring_item).to be(ring_item2)
      end
    end
  end

  describe "#transpose_to" do
    it "returns a Ring which is transposed by the given value" do
      old_ring = described_class.new(TestRingItemWrapper, [
        "a",
        "b",
        "c",
        "d",
      ])
      old_ring_contents = old_ring.map do |ring_item|
        [ring_item.value, ring_item.index]
      end
      expect(old_ring_contents).to eq([
        ["a", 0],
        ["b", 1],
        ["c", 2],
        ["d", 3],
      ])

      new_ring = old_ring.transpose_to("c")
      new_ring_contents = new_ring.map do |ring_item|
        [ring_item.value, ring_item.index]
      end
      expect(new_ring_contents).to eq([
        ["c", 0],
        ["d", 1],
        ["a", 2],
        ["b", 3],
      ])
    end
  end
end
