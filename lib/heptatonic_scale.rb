require_relative "note"
require_relative "tone"

class HeptatonicScale
  def self.canonical_keys_from(starting_note)
    keys = Note::LETTER_TONE_INDICES.map do |letter, letter_tone_index|
      tone_index = letter_tone_index - starting_note.tone_index
      { letter: letter, tone: Tone.new(tone_index) }
    end

    keys.sort { |a, b| a[:tone].index - b[:tone].index }
  end

  def initialize(tones, starting_note: Note.new(:c, :natural))
    @tones = tones
    @starting_note = starting_note
    @canonical_keys = self.class.canonical_keys_from(starting_note)
  end

  def notes
    notes = notes_before_respelling
    letter_offset = starting_note.letter_index - notes.first.letter_index

    if letter_offset != 0
      notes.map { |note| note.respell_with(letter_offset: letter_offset) }
    else
      notes
    end
  end

  private

  attr_reader :tones, :starting_note, :canonical_keys

  def notes_before_respelling
    tones.map.with_index do |tone, index|
      key = canonical_keys.fetch(index)
      offset_from_key = tone.index - key[:tone].index
      accidental = Note::ACCIDENTALS_BY_OFFSET.fetch(offset_from_key)
      Note.new(key[:letter], accidental)
    end
  end

  # def accidental_preference
    # if starting_note.accidental == :flat
      # :flat
    # else
      # :sharp
    # end
  # end

  class Note < ::Note
    def to_s
      symbol = Note::ACCIDENTAL_SYMBOLS.fetch(accidental)
      string = letter.to_s.upcase

      if accidental != :natural
        string << symbol
      end

      string
    end
  end
end
