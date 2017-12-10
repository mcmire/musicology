require "spec_helper"
require_relative "../../lib/musicology/heptatonic_scale"
require_relative "../../lib/musicology/note_names"
require_relative "../../lib/musicology/tones"

describe Musicology::HeptatonicScale do
  describe "#notes" do
    context "using a major scale" do
      it "returns the correct notes when starting from C" do
        tones = [0, 2, 4, 5, 7, 9, 11].map { |index| Musicology.Tone(index) }
        starting_note = Musicology.NoteSpelling(:c, :natural)
        scale = described_class.new(tones, starting_note: starting_note)

        expect(spell(scale)).to eq(
          ["C", "D", "E", "F", "G", "A", "B"],
        )
      end

      it "returns the correct notes when starting from a white key other than C" do
        tones = [0, 2, 4, 5, 7, 9, 11].map { |index| Musicology.Tone(index) }
        starting_note = Musicology.NoteSpelling(:a, :natural)
        scale = described_class.new(tones, starting_note: starting_note)

        expect(spell(scale)).to eq(
          ["A", "B", "C♯", "D", "E", "F♯", "G♯"],
        )
      end

      it "returns the correct notes when starting from a 'flat' black key" do
        tones = [0, 2, 4, 5, 7, 9, 11].map { |index| Musicology.Tone(index) }
        starting_note = Musicology.NoteSpelling(:b, :flat)
        scale = described_class.new(tones, starting_note: starting_note)

        expect(spell(scale)).to eq(
          ["B♭", "C", "D", "E♭", "F", "G", "A"],
        )
      end

      it "returns the correct notes when starting from a 'sharp' black key" do
        tones = [0, 2, 4, 5, 7, 9, 11].map { |index| Musicology.Tone(index) }
        starting_note = Musicology.NoteSpelling(:f, :sharp)
        scale = described_class.new(tones, starting_note: starting_note)

        expect(spell(scale)).to eq(
          ["F♯", "G♯", "A♯", "B", "C♯", "D♯", "E♯"],
        )
      end
    end

    context "using a harmonic minor scale" do
      it "returns the correct notes when starting from C" do
        tones = [0, 2, 3, 5, 7, 8, 11].map { |index| Musicology.Tone(index) }
        starting_note = Musicology.NoteSpelling(:c, :natural)
        scale = described_class.new(tones, starting_note: starting_note)

        expect(spell(scale)).to eq(
          ["C", "D", "E♭", "F", "G", "A♭", "B"],
        )
      end

      it "returns the correct notes when starting from a white key other than C" do
        tones = [0, 2, 3, 5, 7, 8, 11].map { |index| Musicology.Tone(index) }
        starting_note = Musicology.NoteSpelling(:a, :natural)
        scale = described_class.new(tones, starting_note: starting_note)

        expect(spell(scale)).to eq(
          ["A", "B", "C", "D", "E", "F", "G♯"],
        )
      end

      it "returns the correct notes when starting from a 'flat' black key" do
        tones = [0, 2, 3, 5, 7, 8, 11].map { |index| Musicology.Tone(index) }
        starting_note = Musicology.NoteSpelling(:b, :flat)
        scale = described_class.new(tones, starting_note: starting_note)

        expect(spell(scale)).to eq(
          ["B♭", "C", "D♭", "E♭", "F", "G♭", "A"],
        )
      end

      it "returns the correct notes when starting from a 'sharp' black key" do
        tones = [0, 2, 3, 5, 7, 8, 11].map { |index| Musicology.Tone(index) }
        starting_note = Musicology.NoteSpelling(:f, :sharp)
        scale = described_class.new(tones, starting_note: starting_note)

        expect(spell(scale)).to eq(
          ["F♯", "G♯", "A", "B", "C♯", "D", "E♯"],
        )
      end
    end
  end

  def spell(scale)
    scale.notes.map { |note| note.spelling.to_s }
  end
end
