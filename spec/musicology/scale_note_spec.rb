require "spec_helper"
require_relative "../../lib/musicology/scale_note"
require_relative "../../lib/musicology/note_names"

describe Musicology::ScaleNote do
  describe "#==" do
    context "given a ScaleNote with an equivalent NoteSpelling and tone" do
      it "returns true" do
        scale_note1 = described_class.new(
          Musicology.NoteSpelling(:g, :sharp),
          9,
        )
        scale_note2 = described_class.new(
          Musicology.NoteSpelling(:g, :sharp),
          9,
        )

        expect(scale_note1).to eq(scale_note2)
      end
    end

    context "given a ScaleNote with a different NoteSpelling but same tone" do
      it "returns false" do
        scale_note1 = described_class.new(
          Musicology.NoteSpelling(:g, :sharp),
          9,
        )
        scale_note2 = described_class.new(
          Musicology.NoteSpelling(:a, :natural),
          9,
        )

        expect(scale_note1).not_to eq(scale_note2)
      end
    end

    context "given a ScaleNote with a different tone but equivalent NoteSpelling" do
      it "returns false" do
        scale_note1 = described_class.new(
          Musicology.NoteSpelling(:g, :sharp),
          9,
        )
        scale_note2 = described_class.new(
          Musicology.NoteSpelling(:g, :sharp),
          8,
        )

        expect(scale_note1).not_to eq(scale_note2)
      end
    end

    context "given something else" do
      it "returns false" do
        scale_note = described_class.new(Musicology.NoteSpelling(:g, :sharp), 9)

        expect(scale_note).not_to eq(:something)
      end
    end
  end


  describe "#to_s" do
    it "returns the spelling + the tone" do
      scale_note = described_class.new(Musicology.NoteSpelling(:g, :sharp), 3)

      expect(scale_note.to_s).to eq("G♯ (3)")
    end
  end
end
