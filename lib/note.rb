require_relative "tone"

class Note
  LETTERS = [:c, :d, :e, :f, :g, :a, :b].freeze
  LETTER_TONE_INDICES = {
    c: 0,
    d: 2,
    e: 4,
    f: 5,
    g: 7,
    a: 9,
    b: 11,
  }.freeze

  ACCIDENTAL_TONE_OFFSETS = {
    double_flat: -2,
    flat: -1,
    natural: 0,
    sharp: +1,
    double_sharp: +2,
  }.freeze
  ACCIDENTALS_BY_OFFSET = ACCIDENTAL_TONE_OFFSETS.invert

  ACCIDENTAL_SYMBOLS = {
    double_flat: "𝄫",
    flat: "♭",
    natural: "♮",
    sharp: "♯",
    double_sharp: "𝄪",
  }.freeze

  attr_reader :letter, :accidental

  def initialize(letter, accidental)
    @letter = letter
    @accidental = accidental
  end

  def letter_index
    LETTERS.find_index(letter)
  end

  def letter_tone_index
    LETTER_TONE_INDICES.fetch(letter)
  end

  def accidental_index
    ACCIDENTAL_TONE_OFFSETS.fetch(accidental)
  end

  def tone_index
    Tone.new(letter_tone_index + accidental_index).index
  end

  def respell_with(letter_offset:)
    if letter_offset.zero?
      self
    else
      respelled_letter_index = (letter_index + letter_offset) % LETTERS.length
      respelled_letter = LETTERS.fetch(respelled_letter_index)
      respelled_letter_tone_index = LETTER_TONE_INDICES.fetch(respelled_letter)
      new_accidental_offset = tone_index - respelled_letter_tone_index
      new_accidental = ACCIDENTALS_BY_OFFSET.fetch(new_accidental_offset)
      self.class.new(respelled_letter, new_accidental)
    end
  end

  def to_tone
    tone_index =
      LETTER_TONE_INDICES.fetch(letter) +
      ACCIDENTAL_TONE_OFFSETS.fetch(accidental)

    Tone.new(tone_index)
  end

  def ==(other)
    other.is_a?(self.class) && to_tone == other.to_tone
  end

  def to_s
    "#<Note letter: %s, accidental: %s>" % [
      letter.to_s.upcase.inspect,
      ACCIDENTAL_SYMBOLS.fetch(accidental).inspect,
    ]
  end

  alias_method :inspect, :to_s
end
