require "spec_helper"
require_relative "../lib/accidental"
require_relative "../lib/accidentals"

describe Accidental do
  describe "#+" do
    it "returns the accidental N places ahead" do
      expect(Accidental(:flat) + 2).to eq(Accidental(:sharp))
    end
  end

  describe "#-" do
    it "returns the accidental N places behind" do
      expect(Accidental(:sharp) - 2).to eq(Accidental(:flat))
    end
  end

  describe "#==" do
    context "given an Accidental" do
      context "matching name, offset, and symbol" do
        it "returns true" do
          accidental1 = described_class.new(nil, :natural, 0, "♮")
          accidental2 = described_class.new(nil, :natural, 0, "♮")

          expect(accidental1).to eq(accidental2)
        end
      end

      context "not matching name, offset, and symbol" do
        it "returns false" do
          accidental1 = described_class.new(nil, :natural, 0, "♮")
          accidental2 = described_class.new(nil, :sharp, 1, "♯")

          expect(accidental1).not_to eq(accidental2)
        end
      end
    end

    context "given a symbol" do
      context "matching the Accidental's symbol" do
        it "returns true" do
          accidental = described_class.new(nil, :natural, 0, "♮")

          expect(accidental).to eq(:natural)
        end
      end

      context "not matching the Accidental's symbol" do
        it "returns false" do
          accidental = described_class.new(nil, :natural, 0, "♮")

          expect(accidental).not_to eq(:sharp)
        end
      end
    end

    context "given an offset" do
      context "matching the Accidental's offset" do
        it "returns true" do
          accidental = described_class.new(nil, :natural, 0, "♮")

          expect(accidental).to eq(0)
        end
      end

      context "not matching the Accidental's symbol" do
        it "returns false" do
          accidental = described_class.new(nil, :natural, 0, "♮")

          expect(accidental).not_to eq(-1)
        end
      end
    end
  end

  describe "#to_s" do
    it "returns the class + symbol" do
      accidental = described_class.new(nil, :natural, 0, "♮")

      expect(accidental.to_s).to eq("#<Accidental ♮>")
    end
  end
end
