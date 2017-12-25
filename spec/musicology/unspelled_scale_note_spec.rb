require "spec_helper"
require_relative "../../lib/musicology/unspelled_scale_note"
require_relative "../../lib/musicology/notes"
require_relative "../../lib/musicology/letters"

describe Musicology::UnspelledScaleNote do
  describe "#name" do
    it "returns the default spelling of the Note in string form" do
      unspelled_scale_note = described_class.new(
        Musicology.Note(:d, :flat),
        0,
      )

      expect(unspelled_scale_note.name).to eq("C♯")
    end
  end

  describe "#letter" do
    it "returns the letter of the Note's default spelling" do
      unspelled_scale_note = described_class.new(
        Musicology.Note(:d, :flat),
        0,
      )

      expect(unspelled_scale_note.letter).to eq(Musicology.Letter(:c))
    end
  end

  describe "#==" do
    context "given a ScaleNote" do
      context "with an equivalent Note and tone" do
        it "returns true" do
          unspelled_scale_note1 = described_class.new(
            Musicology.Note(:g, :sharp),
            9,
          )
          unspelled_scale_note2 = described_class.new(
            Musicology.Note(:g, :sharp),
            9,
          )

          expect(unspelled_scale_note1).to eq(unspelled_scale_note2)
        end
      end

      context "with a different Note but same tone" do
        it "returns false" do
          unspelled_scale_note1 = described_class.new(
            Musicology.Note(:g, :sharp),
            9,
          )
          unspelled_scale_note2 = described_class.new(
            Musicology.Note(:a, :natural),
            9,
          )

          expect(unspelled_scale_note1).not_to eq(unspelled_scale_note2)
        end
      end

      context "with a different tone but equivalent Note" do
        it "returns false" do
          unspelled_scale_note1 = described_class.new(
            Musicology.Note(:g, :sharp),
            9,
          )
          unspelled_scale_note2 = described_class.new(
            Musicology.Note(:g, :sharp),
            8,
          )

          expect(unspelled_scale_note1).not_to eq(unspelled_scale_note2)
        end
      end
    end

    context "given something else" do
      it "returns false" do
        unspelled_scale_note = described_class.new(
          Musicology.Note(:g, :sharp),
          9,
        )

        expect(unspelled_scale_note).not_to eq(:something)
      end
    end
  end

  describe "#to_s" do
    it "returns the string version of the note + the tone" do
      unspelled_scale_note = described_class.new(
        Musicology.Note(:g, :sharp),
        3,
      )

      expect(unspelled_scale_note.to_s).to eq("G♯ / A♭ (3)")
    end
  end
end
