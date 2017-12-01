require "spec_helper"
require_relative "../lib/accidental_collection"

describe AccidentalCollection do
  describe "#find!" do
    context "given an Accidental" do
      context "that matches one in the AccidentalCollection" do
        it "returns that Accidental" do
          accidental_collection = described_class.new([
            { name: :double_flat, offset: 2, symbol: "𝄫" },
          ])

          accidental = Accidental.new(nil, :double_flat, 2, "𝄫")

          expect(accidental_collection.find!(accidental)).to eq(accidental)
        end
      end

      context "that does not match one in the AccidentalCollection" do
        it "raises an AccidentalNotFoundError" do
          accidental_collection = described_class.new([
            { name: :double_flat, offset: 2, symbol: "𝄫" },
          ])

          accidental = Accidental.new(nil, :sharp, 1, "♯")

          expect(-> { accidental_collection.find!(accidental) }).
            to raise_error(AccidentalNotFoundError)
        end
      end
    end

    context "given the name of an Accidental" do
      context "that exists in the AccidentalCollection" do
        it "returns that Accidental" do
          accidental_collection = described_class.new([
            { name: :double_flat, offset: 2, symbol: "𝄫" },
          ])

          expect(accidental_collection.find!(:double_flat)).
            to eq(Accidental.new(nil, :double_flat, 2, "𝄫"))
        end
      end

      context "that does not exist in the AccidentalCollection" do
        it "raises an AccidentalNotFoundError" do
          accidental_collection = described_class.new([
            { name: :double_flat, offset: 2, symbol: "𝄫" },
          ])

          expect(-> { accidental_collection.find!(:sharp) }).
            to raise_error(AccidentalNotFoundError)
        end
      end
    end

    context "given the offset of an Accidental" do
      context "that exists in the AccidentalCollection" do
        it "returns that Accidental" do
          accidental_collection = described_class.new([
            { name: :double_flat, offset: 2, symbol: "𝄫" },
          ])

          expect(accidental_collection.find!(2)).
            to eq(Accidental.new(nil, :double_flat, 2, "𝄫"))
        end
      end

      context "that does not exist in the AccidentalCollection" do
        it "raises an AccidentalNotFoundError" do
          accidental_collection = described_class.new([
            { name: :double_flat, offset: 2, symbol: "𝄫" },
          ])

          expect(-> { accidental_collection.find!(-1) }).
            to raise_error(AccidentalNotFoundError)
        end
      end
    end

    context "given the symbol of an Accidental" do
      context "that exists in the AccidentalCollection" do
        it "returns that Accidental" do
          accidental_collection = described_class.new([
            { name: :double_flat, offset: 2, symbol: "𝄫" },
          ])

          expect(accidental_collection.find!(:double_flat)).
            to eq(Accidental.new(nil, :double_flat, 2, "𝄫"))
        end
      end

      context "that does not exist in the AccidentalCollection" do
        it "raises an AccidentalNotFoundError" do
          accidental_collection = described_class.new([
            { name: :double_flat, offset: 2, symbol: "𝄫" },
          ])

          expect(-> { accidental_collection.find!(:sharp) }).
            to raise_error(AccidentalNotFoundError)
        end
      end
    end
  end
end
