require "spec_helper"
require_relative "../../lib/musicology/note"
require_relative "../../lib/musicology/notes"
require_relative "../../lib/musicology/letters"

describe Musicology::Note do
  describe "#default_name" do
    context "given a note with a natural spelling" do
      it "returns that spelling" do
        note = Musicology.Note(:f, :natural)

        expect(note.default_name).to eq("F")
      end
    end

    context "given a note without a natural spelling" do
      it "returns the sharp spelling" do
        note = Musicology.Note(:g, :sharp)

        expect(note.default_name).to eq("G♯")
      end
    end
  end

  describe "#default_letter" do
    context "given a note with a natural spelling" do
      it "returns the letter of that spelling" do
        note = Musicology.Note(:f, :natural)

        expect(note.default_letter).to eq(Musicology.Letter(:f))
      end
    end

    context "given a note without a natural spelling" do
      it "returns the letter of the sharp spelling" do
        note = Musicology.Note(:g, :sharp)

        expect(note.default_letter).to eq(Musicology.Letter(:g))
      end
    end
  end

  describe "#==" do
    context "given another Note" do
      context "if it has the same spellings as this Note" do
        it "returns true" do
          note1 = Musicology::Note.new([
            [:c, :sharp],
            [:d, :flat],
          ])
          note2 = Musicology::Note.new([
            [:c, :sharp],
            [:d, :flat],
          ])

          expect(note1).to eq(note2)
        end
      end

      context "if it has different spellings as this Note" do
        it "returns false" do
          note1 = Musicology::Note.new([
            [:c, :sharp],
            [:d, :flat],
          ])
          note2 = Musicology::Note.new([
            [:e, :sharp],
            [:f, :natural],
          ])

          expect(note1).not_to eq(note2)
        end
      end
    end

    context "given a NoteSpelling" do
      context "if this Note has the NoteSpelling" do
        it "returns true" do
          note = Musicology::Note.new([
            [:c, :sharp],
            [:d, :flat],
          ])

          expect(note).to eq(Musicology.NoteSpelling(:c, :sharp))
        end
      end

      context "if this Note does not have the NoteSpelling" do
        it "returns false" do
          note = Musicology::Note.new([
            [:c, :sharp],
            [:d, :flat],
          ])

          expect(note).not_to eq(Musicology.NoteSpelling(:e, :sharp))
        end
      end
    end
  end
end
