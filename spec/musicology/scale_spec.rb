require "spec_helper"
require_relative "../../lib/musicology/scale"

describe Musicology::Scale do
  describe "#valid?" do
    context "if the root tone is on and none of the intervals is greater than a major third" do
      it "returns true" do
        scale = described_class.new(0b100000000001)

        expect(scale).to be_valid
      end
    end

    context "when one of the intervals is greater than a major third" do
      it "returns false" do
        scale = described_class.new(0b010000111011)

        expect(scale).not_to be_valid
      end
    end

    context "if the root tone is off" do
      it "returns false" do
        scale = described_class.new(0b111111111110)

        expect(scale).not_to be_valid
      end
    end
  end

  describe "#notes" do
    context "given a NoteSpelling" do
      it "returns all of the notes in the scale starting from that note, as correct NoteSpellings" do
        scale = described_class.new(0b101010110101)
        anchor = Musicology.NoteSpelling(:a, :natural)

        notes = scale.notes(starting_on: anchor)

        expect(notes.map(&:name)).to eq(
          ["A", "B", "C♯", "D", "E", "F♯", "G♯"],
        )
      end
    end

    context "given a Note" do
      it "returns all of the notes in the scale starting from that note, as Notes" do
        scale = described_class.new(0b101010110101)
        anchor = Musicology.Note(:a, :natural)

        notes = scale.notes(starting_on: anchor)

        expect(notes.map(&:name)).to eq(
          ["A", "B", "C♯", "D", "E", "F♯", "G♯"],
        )
      end
    end

    context "given no starting note" do
      it "returns the notes in the scale starting on C" do
        scale = described_class.new(0b101010110101)

        notes = scale.notes

        expect(notes.map(&:name)).to eq(
          ["C", "D", "E", "F", "G", "A", "B"],
        )
      end
    end
  end

  describe "#tones" do
    it "returns the tones represented by the word" do
      scale = described_class.new(0b100010100101)

      expect(scale.tones).to eq([0, 2, 5, 7, 11])
    end
  end

  describe "#modes" do
    context "given a valid Scale" do
      it "returns all rotations that produce valid Scales" do
        scale = described_class.new(0b000101001011)

        expect(scale.modes).to eq([
          described_class.new(0b100010100101),
          described_class.new(0b011000101001),
          described_class.new(0b001011000101),
          described_class.new(0b010010110001),
        ])
      end
    end

    context "given a Scale whose root tone is off" do
      it "returns an empty array" do
        scale = described_class.new(0b000101001010)

        expect(scale.modes).to eq([])
      end
    end

    context "given a Scale that has large leaps" do
      it "returns an empty array" do
        scale = described_class.new(0b000011001011)

        expect(scale.modes).to eq([])
      end
    end
  end

  describe "#rotate_right" do
    it "bitwise-rotates the scale to the right" do
      scale = described_class.new(0b000101001011)
      rotated_scale = described_class.new(0b100010100101)

      expect(scale.rotate_right).to eq(rotated_scale)
    end
  end

  describe "#rotation_of?" do
    context "when this Scale is a rotation of the given Scale" do
      it "returns true" do
        scale1 = described_class.new(0b101010110101)
        scale2 = described_class.new(0b101011010101)

        expect(scale1).to be_rotation_of(scale2)
      end
    end

    context "when this Scale is the same as the given Scale" do
      it "returns false" do
        scale1 = described_class.new(0b101010110101)
        scale2 = described_class.new(0b101010110101)

        expect(scale1).not_to be_rotation_of(scale2)
      end
    end

    context "when this Scale is not a rotation of the given Scale" do
      it "returns false" do
        scale1 = described_class.new(0b000100011001)
        scale2 = described_class.new(0b000100010001)

        expect(scale1).not_to be_rotation_of(scale2)
      end
    end
  end

  describe "#equivalent_to?" do
    context "given the same Scale" do
      it "returns true" do
        scale1 = described_class.new(0b101010110101)
        scale2 = described_class.new(0b101010110101)

        expect(scale1).to be_equivalent_to(scale2)
      end
    end

    context "given another Scale" do
      context "when this Scale is a rotation of the given Scale" do
        it "returns true" do
          scale1 = described_class.new(0b101010110101)
          scale2 = described_class.new(0b101011010101)

          expect(scale1).to be_equivalent_to(scale2)
        end
      end

      context "when this Scale has the same interval spectrum as the given Scale but is not a rotation" do
        it "returns false" do
          scale1 = described_class.new(0b000100011001)
          scale2 = described_class.new(0b000100010011)

          expect(scale1).not_to be_equivalent_to(scale2)
        end
      end

      context "when this Scale has a different interval spectrum than the given Scale" do
        it "returns false" do
          scale1 = described_class.new(0b000100011001)
          scale2 = described_class.new(0b000100010001)

          expect(scale1).not_to be_equivalent_to(scale2)
        end
      end
    end

    context "given something else" do
      it "returns false" do
        scale = described_class.new(0b101010110101)

        expect(scale).not_to be_equivalent_to(:something)
      end
    end
  end

  describe "#==" do
    context "given another Scale" do
      context "that has the same word" do
        it "returns true" do
          scale1 = described_class.new(0b000100011001)
          scale2 = described_class.new(0b000100011001)

          expect(scale1).to eq(scale2)
        end
      end

      context "that does not have the same word, even if it is a rotation" do
        it "returns false" do
          scale1 = described_class.new(0b000100011001)
          scale2 = described_class.new(0b0110010001000)

          expect(scale1).not_to eq(scale2)
        end
      end
    end

    context "given something else" do
      it "returns false" do
        scale = described_class.new(0b000100011001)

        expect(scale).not_to eq(:something)
      end
    end
  end
end
