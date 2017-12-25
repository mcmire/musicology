require "spec_helper"
require_relative "../../lib/musicology/anchored_scale"
require_relative "../../lib/musicology/notes"
require_relative "../../lib/musicology/scale"

describe Musicology::AnchoredScale do
  describe "#notes" do
    context "given a NoteSpelling" do
      context "using a major scale" do
        it "returns the correct notes when starting from C" do
          scale = Musicology::Scale.new(0b101010110101)
          anchor = Musicology.NoteSpelling(:c, :natural)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["C", "D", "E", "F", "G", "A", "B"],
          )
        end

        it "returns the correct notes when starting from a white key other than C" do
          scale = Musicology::Scale.new(0b101010110101)
          anchor = Musicology.NoteSpelling(:a, :natural)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["A", "B", "C♯", "D", "E", "F♯", "G♯"],
          )
        end

        it "returns the correct notes when starting from a 'flat' black key" do
          scale = Musicology::Scale.new(0b101010110101)
          anchor = Musicology.NoteSpelling(:b, :flat)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["B♭", "C", "D", "E♭", "F", "G", "A"],
          )
        end

        it "returns the correct notes when starting from a 'sharp' black key" do
          scale = Musicology::Scale.new(0b101010110101)
          anchor = Musicology.NoteSpelling(:f, :sharp)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["F♯", "G♯", "A♯", "B", "C♯", "D♯", "E♯"],
          )
        end
      end

      context "using a harmonic minor scale" do
        it "returns the correct notes when starting from C" do
          scale = Musicology::Scale.new(0b100110101101)
          anchor = Musicology.NoteSpelling(:c, :natural)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["C", "D", "E♭", "F", "G", "A♭", "B"],
          )
        end

        it "returns the correct notes when starting from a white key other than C based on sharps" do
          scale = Musicology::Scale.new(0b100110101101)
          anchor = Musicology.NoteSpelling(:a, :natural)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["A", "B", "C", "D", "E", "F", "G♯"],
          )
        end

        it "returns the correct notes when starting from a white key other than C based on sharps" do
          scale = Musicology::Scale.new(0b100110101101)
          anchor = Musicology.NoteSpelling(:f, :natural)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["F", "G", "A♭", "B♭", "C", "D♭", "E"],
          )
        end

        it "returns the correct notes when starting from a 'flat' black key" do
          scale = Musicology::Scale.new(0b100110101101)
          anchor = Musicology.NoteSpelling(:b, :flat)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["B♭", "C", "D♭", "E♭", "F", "G♭", "A"],
          )
        end

        it "returns the correct notes when starting from a 'sharp' black key" do
          scale = Musicology::Scale.new(0b100110101101)
          anchor = Musicology.NoteSpelling(:f, :sharp)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["F♯", "G♯", "A", "B", "C♯", "D", "E♯"],
          )
        end
      end

      context "when some letters need to be repeated" do
        it "returns the correct notes" do
          scale = Musicology::Scale.new(0b001011110101)
          anchor = Musicology.NoteSpelling(:c, :flat)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["C♭", "D♭", "E♭", "F♭", "G𝄫", "G♭", "A♭"],
          )
        end
      end

      context "for a non-heptatonic scale with large intervals" do
        it "returns the correct notes" do
          scale = Musicology::Scale.new(0b100100010001)
          anchor = Musicology.NoteSpelling(:f, :sharp)
          anchored_scale = described_class.new(scale, anchor)

          notes = anchored_scale.notes

          expect(notes.map(&:name)).to eq(
            ["F♯", "A♯", "C𝄪", "E♯"],
          )
        end
      end

      context "for a heptatonic scale with large intervals" do
        it "returns the correct notes" do
          anchor = Musicology.NoteSpelling(:f, :sharp)

          scale1 = Musicology::Scale.new(0b111101010001)
          anchored_scale1 = described_class.new(scale1, anchor)
          notes1 = anchored_scale1.notes

          scale2 = Musicology::Scale.new(0b111111000001)
          anchored_scale2 = described_class.new(scale2, anchor)
          notes2 = anchored_scale2.notes

          expect(notes1.map(&:name)).to eq(
            ["F♯", "A♯", "B♯", "C𝄪", "D♯", "E", "E♯"],
          )
          expect(notes2.map(&:name)).to eq(
            ["F♯", "B♯", "C♯", "D", "D♯", "E", "E♯"],
          )
        end
      end
    end

    context "given a Note" do
      it "returns the correct notes" do
        scale = Musicology::Scale.new(0b101010110101)
        anchor = Musicology.NoteSpelling(:c, :natural)
        anchored_scale = described_class.new(scale, anchor)

        notes = anchored_scale.notes

        expect(notes.map(&:name)).to eq(
          ["C", "D", "E", "F", "G", "A", "B"],
        )
      end
    end
  end

  describe "#modes" do
    context "given a NoteSpelling" do
      it "returns versions of the scale resulting in rotation of all NoteSpellings" do
        scale = Musicology::Scale.new(0b101010110101)
        anchor = Musicology.NoteSpelling(:d, :natural)
        anchored_scale = described_class.new(scale, anchor)

        modes = anchored_scale.modes

        expect(modes.map(&:note_names)).to eq([
          ["E", "F♯", "G", "A", "B", "C♯", "D"],
          ["F♯", "G", "A", "B", "C♯", "D", "E"],
          ["G", "A", "B", "C♯", "D", "E", "F♯"],
          ["A", "B", "C♯", "D", "E", "F♯", "G"],
          ["B", "C♯", "D", "E", "F♯", "G", "A"],
          ["C♯", "D", "E", "F♯", "G", "A", "B"],
        ])
      end
    end

    context "given a Note" do
      it "returns versions of the scale resulting in rotation of all Notes" do
        scale = Musicology::Scale.new(0b101010110101)
        anchor = Musicology.Note(:d, :natural)
        anchored_scale = described_class.new(scale, anchor)

        modes = anchored_scale.modes

        expect(modes.map { |mode| mode.notes.map(&:name) }).to eq([
          ["E", "F♯", "G", "A", "B", "C♯", "D"],
          ["F♯", "G", "A", "B", "C♯", "D", "E"],
          ["G", "A", "B", "C♯", "D", "E", "F♯"],
          ["A", "B", "C♯", "D", "E", "F♯", "G"],
          ["B", "C♯", "D", "E", "F♯", "G", "A"],
          ["C♯", "D", "E", "F♯", "G", "A", "B"],
        ])
      end
    end
  end
end
