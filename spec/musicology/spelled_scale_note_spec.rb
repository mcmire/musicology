require "spec_helper"
require_relative "../../lib/musicology/spelled_scale_note"
require_relative "../../lib/musicology/notes"
require_relative "../../lib/musicology/letters"

describe Musicology::SpelledScaleNote do
  describe "#name" do
    it "returns the spelling in string form" do
      spelled_scale_note = described_class.new(
        Musicology.NoteSpelling(:d, :flat),
        0,
      )

      expect(spelled_scale_note.name).to eq("D♭")
    end
  end

  describe "#letter" do
    it "returns its letter" do
      spelled_scale_note = described_class.new(
        Musicology.NoteSpelling(:d, :flat),
        0,
      )

      expect(spelled_scale_note.letter).to eq(Musicology.Letter(:d))
    end
  end

  describe "#==" do
    context "given a ScaleNote" do
      context "with an equivalent NoteSpelling and tone" do
        it "returns true" do
          spelled_scale_note1 = described_class.new(
            Musicology.NoteSpelling(:g, :sharp),
            9,
          )
          spelled_scale_note2 = described_class.new(
            Musicology.NoteSpelling(:g, :sharp),
            9,
          )

          expect(spelled_scale_note1).to eq(spelled_scale_note2)
        end
      end

      context "with a different NoteSpelling but same tone" do
        it "returns false" do
          spelled_scale_note1 = described_class.new(
            Musicology.NoteSpelling(:g, :sharp),
            9,
          )
          spelled_scale_note2 = described_class.new(
            Musicology.NoteSpelling(:a, :natural),
            9,
          )

          expect(spelled_scale_note1).not_to eq(spelled_scale_note2)
        end
      end

      context "with a different tone but equivalent NoteSpelling" do
        it "returns false" do
          spelled_scale_note1 = described_class.new(
            Musicology.NoteSpelling(:g, :sharp),
            9,
          )
          spelled_scale_note2 = described_class.new(
            Musicology.NoteSpelling(:g, :sharp),
            8,
          )

          expect(spelled_scale_note1).not_to eq(spelled_scale_note2)
        end
      end
    end

    context "given something else" do
      it "returns false" do
        spelled_scale_note = described_class.new(
          Musicology.NoteSpelling(:g, :sharp),
          9,
        )

        expect(spelled_scale_note).not_to eq(:something)
      end
    end
  end

  describe "#to_s" do
    it "returns the spelling + the tone" do
      spelled_scale_note = described_class.new(
        Musicology.NoteSpelling(:g, :sharp),
        3,
      )

      expect(spelled_scale_note.to_s).to eq("G♯ (3)")
    end
  end
end
