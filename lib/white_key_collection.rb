require_relative "ring"
require_relative "white_key"

class WhiteKeyCollection < Ring
  def initialize(values)
    super(WhiteKey, values)
  end

  def transpose_to(note)
    letters = items.map(&:letter)
    tones = items.map { |k| k.tone - note.tone.to_i }
    values = letters.zip(tones).
      map { |letter, tone| { letter: letter, tone: tone } }.
      sort { |a, b| a[:tone].to_i - b[:tone].to_i }

    self.class.new(values)
  end
end
