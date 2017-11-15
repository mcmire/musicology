require_relative "accidentals"
require_relative "note"
require_relative "scale_note"
require_relative "white_keys"

class HeptatonicScale
  def initialize(tones, starting_note: Note.new(:c, :natural))
    @tones = tones
    @starting_note = starting_note
    @white_keys = WhiteKeys.transpose_to(starting_note)
  end

  def notes
    notes = notes_before_respelling
    letter_offset = starting_note.white_key.letter - notes.first.white_key.letter

    if letter_offset != 0
      notes.map { |note| note.respell_with(letter_offset: letter_offset) }
    else
      notes
    end
  end

  private

  attr_reader :tones, :starting_note, :white_keys, :transposition_offset

  def notes_before_respelling
    tones.map.with_index do |tone, index|
      white_key = white_keys.at(index)
      accidental_offset = tone - white_key.tone
      accidental = Accidentals[accidental_offset]
      ScaleNote.new(white_key, accidental)
    end
  end
end
