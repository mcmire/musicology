require "spec_helper"
require_relative "../../lib/musicology/scale_discoverer"
require_relative "../../lib/musicology/notes"

describe Musicology::ScaleDiscoverer do
  it "returns the modal families across all keys that contain the note" do
    note = Musicology.Note(:e, :natural)
    major_scale = 2741

    matches = described_class.call(note)

    interesting_modal_families = matches.select do |modal_family|
      modal_family.scales.any? do |scale|
        scale.word == major_scale
      end
    end
    interesting_scales = interesting_modal_families.flat_map do |modal_family|
      modal_family.scales.map do |scale|
        {
          key: "#{scale.anchor.default_name} #{scale.default_name}",
          note_names: scale.notes.map(&:name),
        }
      end
    end
    expect(interesting_modal_families.size).to eq(7)
    expect(interesting_scales).to include({
      key: "C major",
      note_names: ["C", "D", "E", "F", "G", "A", "B"],
    })
    expect(interesting_scales).to include({
      key: "D major",
      note_names: ["D", "E", "F♯", "G", "A", "B", "C♯"],
    })
    expect(interesting_scales).to include({
      key: "E major",
      note_names: ["E", "F♯", "G♯", "A", "B", "C♯", "D♯"],
    })
    expect(interesting_scales).to include({
      key: "F major",
      note_names: ["F", "G", "A", "A♯", "C", "D", "E"],
    })
    expect(interesting_scales).to include({
      key: "G major",
      note_names: ["G", "A", "B", "C", "D", "E", "F♯"],
    })
    expect(interesting_scales).to include({
      key: "A major",
      note_names: ["A", "B", "C♯", "D", "E", "F♯", "G♯"],
    })
    expect(interesting_scales).to include({
      key: "B major",
      note_names: ["B", "C♯", "D♯", "E", "F♯", "G♯", "A♯"],
    })
  end
end
