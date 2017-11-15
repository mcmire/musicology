require_relative "accidentals"
require_relative "white_keys"

class Note
  def self.random
    white_key = WhiteKeys.sample
    accidental = Accidentals.sample
    new(white_key, accidental)
  end

  attr_reader :white_key, :accidental

  def initialize(white_key, accidental)
    @white_key = WhiteKeys[white_key]
    @accidental = Accidentals[accidental]
  end

  def tone_index
    tone.index
  end

  def tone
    white_key_tone + accidental_offset
  end

  def white_key_letter_index
    white_key_letter.index
  end

  def white_key_letter_name
    white_key_letter.value
  end

  def white_key_letter
    white_key.letter
  end

  def white_key_tone_index
    white_key_tone.index
  end

  def white_key_tone
    white_key.tone
  end

  def accidental_offset
    accidental.offset
  end

  def respell_with(letter_offset:)
    if letter_offset.zero?
      self
    else
      respelled_white_key = white_key + letter_offset
      accidental_offset = white_key_tone - respelled_white_key.tone
      respelled_accidental = accidental + accidental_offset
      self.class.new(respelled_white_key, respelled_accidental)
    end
  end

  def ==(other)
    other.is_a?(self.class) && tone == other.tone
  end

  def to_s
    "#<Note %s%s>" % [
      white_key_letter_name.to_s.upcase,
      accidental.symbol,
    ]
  end

  alias_method :inspect, :to_s
end
