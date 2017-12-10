require_relative "scale_note"
require_relative "note_names"

class HeptatonicScale
  def initialize(tones, starting_note: NoteSpelling(:c, :natural))
    @tones = tones.map { |tone| Tone(tone) }
    @starting_note = starting_note
    @available_note_names = NoteNames.transpose_to(starting_note)
  end

  def notes
    tones.reduce([]) do |notes, tone|
      if tone == 0
        notes << ScaleNote.new(starting_note, tone)
      else
        note_name = available_note_names.find!(tone.index)

        note_spelling = note_name.spellings.detect do |spelling|
          spelling.letter == notes.last.spelling.letter + 1
        end

        notes << ScaleNote.new(note_spelling, tone)
      end
    end
  end

  private

  attr_reader :tones, :starting_note, :available_note_names
end
