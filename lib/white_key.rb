require_relative "letters"
require_relative "tones"

class WhiteKey
  attr_reader :letter, :tone

  def initialize(letter:, tone:)
    @letter = Letters[letter]
    @tone = Tones[tone]
  end

  # TODO: Is this called?
  # def -(white_key)
    # new_letter = letter - white_key.letter_index
    # new_tone = tone - white_key.tone_index
    # self.class.new(new_letter, new_tone)
  # end

  def ==(value)
    case value
    when self.class
      letter == value.letter && tone == value.tone
    when Symbol
      letter == value
    when Integer
      tone == value
    else
      false
    end
  end

  def inspect
    StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
  end

  alias_method :to_s, :inspect

  def pretty_print(pp)
    Util.pretty_print_without_object_id(self, pp, letter: letter, tone: tone)
  end
end
