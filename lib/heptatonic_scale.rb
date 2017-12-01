require_relative "scale_note"
require_relative "note_names"

class HeptatonicScale
  def initialize(tones, starting_note: NoteSpelling(:c, :natural))
    @tones = tones.map { |tone| Tone(tone) }
    @starting_note = starting_note
    @available_note_names = NoteNames.transpose_to(starting_note)
  end

  def notes
    tones.map.with_index do |tone, letter_offset|
      new_letter = starting_note.letter + letter_offset
      note_spelling = available_note_names.find!(tone.index).find!(new_letter)
      ScaleNote.new(note_spelling, tone)
    end
  end

  private

  attr_reader :tones, :starting_note, :available_note_names
end
