require "spec_helper"
require_relative "../../lib/musicology/accidentals"
require_relative "../../lib/musicology/note"
require_relative "../../lib/musicology/letters"
require_relative "../../lib/musicology/note_spelling"
require_relative "../../lib/musicology/notes"

describe Musicology::NoteSpelling do
  describe "as a method" do
    it "returns the known NoteSpelling that corresponds to the given letter and accidental" do
      note_spelling = Musicology.NoteSpelling(:g, :natural)

      expect(note_spelling).to be_a(described_class)
      expect(note_spelling.letter).to eq(:g)
      expect(note_spelling.accidental).to eq(:natural)
    end
  end

  describe "as a class" do
    describe "#==" do
      context "given a NoteSpelling that has the same letter and accidental" do
        it "returns true" do
          note_spelling1 = described_class.new(nil, :a, :natural)
          note_spelling2 = described_class.new(nil, :a, :natural)

          expect(note_spelling1).to eq(note_spelling2)
        end
      end

      context "given a NoteSpelling that is an equivalent enharmonic" do
        it "returns true" do
          note = Musicology::Note.new([
            [:a, :natural],
            [:g, :double_flat],
          ])

          expect(note.find_spelling!(:a)).to eq(note.find_spelling!(:g))
        end
      end

      context "given a tuple with the same letter and accidental" do
        it "returns true" do
          note_spelling = described_class.new(nil, :a, :natural)

          expect(note_spelling).to eq([
            Musicology.Letter(:a),
            Musicology.Accidental(:natural),
          ])
        end
      end

      context "given something other than a NoteSpelling" do
        it "returns false" do
          note = Musicology::Note.new([])
          note_spelling =
            described_class.new(note, :a, :natural)

          expect(note_spelling).not_to eq(:whatever)
        end
      end

      context "given a different note completely" do
        it "returns false" do
          note = Musicology::Note.new([
            [:a, :natural],
          ])
          note2 = Musicology::Note.new([
            [:f, :sharp],
          ])
          note_spelling1 = note.find_spelling!(:a)
          note_spelling2 = note2.find_spelling!(:f)

          expect(note_spelling1).not_to eq(note_spelling2)
        end
      end
    end

    describe "#equivalent_to?" do
      context "given a NoteSpelling that has the same letter and accidental" do
        it "returns true" do
          note_spelling1 = described_class.new(nil, :a, :natural)
          note_spelling2 = described_class.new(nil, :a, :natural)

          expect(note_spelling1).to be_equivalent_to(note_spelling2)
        end
      end

      context "given a tuple with the same letter and accidental" do
        it "returns true" do
          note_spelling = described_class.new(nil, :a, :natural)

          expect(note_spelling).to be_equivalent_to([
            Musicology.Letter(:a),
            Musicology.Accidental(:natural),
          ])
        end
      end

      context "given something else" do
        it "returns false" do
          note_spelling = described_class.new(nil, :a, :natural)

          expect(note_spelling).not_to be_equivalent_to(:whatever)
        end
      end
    end

    describe "#to_s" do
      context "if the accidental is a natural" do
        it "returns the letter" do
          note_spelling = described_class.new(nil, :g, :natural)

          expect(note_spelling.to_s).to eq("G")
        end
      end

      context "if the accidental is not a natural" do
        it "returns the letter + the accidental" do
          note_spelling = described_class.new(nil, :g, :sharp)

          expect(note_spelling.to_s).to eq("G♯")
        end
      end
    end
  end
end
