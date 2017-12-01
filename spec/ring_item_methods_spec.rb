require "spec_helper"
require_relative "../lib/ring"
require_relative "../lib/ring_item_methods"

describe RingItemMethods do
  describe "#+" do
    it "returns the RingItem N indices clockwise around the ring" do
      ring = Ring.new(TestRingItemWrapper, ["a", "b", "c", "d"])

      expect(ring.find!("a") + 2).to eq(ring.find!("c"))
    end

    it "wraps around the ring if necessary" do
      ring = Ring.new(TestRingItemWrapper, ["a", "b", "c", "d"])

      expect(ring.find!("c") + 2).to eq(ring.find!("a"))
    end
  end

  describe "#-" do
    context "given an integer" do
      it "returns the RingItem N indices counterclockwise around the ring" do
        ring = Ring.new(TestRingItemWrapper, ["a", "b", "c", "d"])

        expect(ring.find!("c") - 2).to eq(ring.find!("a"))
      end

      it "wraps around the ring if necessary" do
        ring = Ring.new(TestRingItemWrapper, ["a", "b", "c", "d"])

        expect(ring.find!("a") - 1).to eq(ring.find!("d"))
      end
    end


    context "given a RingItem" do
      context "whose index is greater than this RingItem" do
        context "when crossing the start of the ring to get to that RingItem" do
          it "returns the correct difference" do
            ring = Ring.new(
              TestRingItemWrapper,
              ["a", "b", "c", "d", "e", "f", "g"],
            )

            expect(ring.find!("a") - ring.find!("g")).to eq(1)
          end
        end

        context "when not crossing the start of the ring to get to that RingItem" do
          it "returns the correct difference" do
            ring = Ring.new(TestRingItemWrapper, ["a", "b", "c", "d"])

            expect(ring.find!("a") - ring.find!("c")).to eq(-2)
          end
        end
      end

      context "whose index is less than this RingItem" do
        context "when crossing the start of the ring to get to that RingItem" do
          it "returns the correct difference" do
            ring = Ring.new(
              TestRingItemWrapper,
              ["a", "b", "c", "d", "e", "f", "g"],
            )

            expect(ring.find!("g") - ring.find!("c")).to eq(-3)
          end
        end

        context "when not crossing the start of the ring to get to that RingItem" do
          it "returns the correct difference" do
            ring = Ring.new(
              TestRingItemWrapper,
              ["a", "b", "c", "d", "e", "f", "g"],
            )

            expect(ring.find!("d") - ring.find!("c")).to eq(1)
          end
        end
      end
    end
  end
end
