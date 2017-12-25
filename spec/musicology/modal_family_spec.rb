require "spec_helper"
require_relative "../../lib/musicology/modal_family"
require_relative "../../lib/musicology/notes"
require_relative "../../lib/musicology/scale"

describe Musicology::ModalFamily do
  describe "#anchor_to" do
    context "given a NoteSpelling" do
      it "returns a ModalFamily consisting of scales that are transposed for every note in the root scale" do
        modal_family = described_class.new([
          Musicology::Scale.new(0b011010101101),
        ])

        anchored_modal_family = modal_family.anchor_to(
          Musicology.NoteSpelling(:c, :natural),
        )

        expect(anchored_modal_family.scales.map(&:note_names)).to eq([
          ["C", "D", "E♭", "F", "G", "A", "B♭"],
          ["D", "E♭", "F", "G", "A", "B♭", "C"],
          ["E♭", "F", "G", "A", "B♭", "C", "D"],
          ["F", "G", "A", "B♭", "C", "D", "E♭"],
          ["G", "A", "B♭", "C", "D", "E♭", "F"],
          ["A", "B♭", "C", "D", "E♭", "F", "G"],
          ["B♭", "C", "D", "E♭", "F", "G", "A"],
        ])
      end
    end

    context "given a Note" do
      it "returns a ModalFamily consisting of scales that are transposed for every note in the root scale" do
        modal_family = described_class.new([
          Musicology::Scale.new(0b011010101101),
        ])

        anchored_modal_family = modal_family.anchor_to(
          Musicology.Note(:c, :natural),
        )

        expect(anchored_modal_family.scales.map(&:note_names)).to eq([
          [
            "B♯ / C / D𝄫",
            "C𝄪 / D / E𝄫",
            "D♯ / E♭ / F𝄪",
            "E♯ / F / G𝄫",
            "F𝄪 / G / A𝄫",
            "G𝄪 / A / B𝄫",
            "A♯ / B♭ / C𝄫",
          ],
          [
            "C𝄪 / D / E𝄫",
            "D♯ / E♭ / F𝄪",
            "E♯ / F / G𝄫",
            "F𝄪 / G / A𝄫",
            "G𝄪 / A / B𝄫",
            "A♯ / B♭ / C𝄫",
            "B♯ / C / D𝄫",
          ],
          [
            "D♯ / E♭ / F𝄪",
            "E♯ / F / G𝄫",
            "F𝄪 / G / A𝄫",
            "G𝄪 / A / B𝄫",
            "A♯ / B♭ / C𝄫",
            "B♯ / C / D𝄫",
            "C𝄪 / D / E𝄫",
          ],
          [
            "E♯ / F / G𝄫",
            "F𝄪 / G / A𝄫",
            "G𝄪 / A / B𝄫",
            "A♯ / B♭ / C𝄫",
            "B♯ / C / D𝄫",
            "C𝄪 / D / E𝄫",
            "D♯ / E♭ / F𝄪",
          ],
          [
            "F𝄪 / G / A𝄫",
            "G𝄪 / A / B𝄫",
            "A♯ / B♭ / C𝄫",
            "B♯ / C / D𝄫",
            "C𝄪 / D / E𝄫",
            "D♯ / E♭ / F𝄪",
            "E♯ / F / G𝄫",
          ],
          [
            "G𝄪 / A / B𝄫",
            "A♯ / B♭ / C𝄫",
            "B♯ / C / D𝄫",
            "C𝄪 / D / E𝄫",
            "D♯ / E♭ / F𝄪",
            "E♯ / F / G𝄫",
            "F𝄪 / G / A𝄫",
          ],
          [
            "A♯ / B♭ / C𝄫",
            "B♯ / C / D𝄫",
            "C𝄪 / D / E𝄫",
            "D♯ / E♭ / F𝄪",
            "E♯ / F / G𝄫",
            "F𝄪 / G / A𝄫",
            "G𝄪 / A / B𝄫",
          ],
        ])
      end
    end
  end
end
