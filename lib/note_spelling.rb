require_relative "accidentals"
require_relative "letters"

class NoteSpelling
  attr_reader :letter, :accidental

  def initialize(group, letter, accidental)
    @group = group
    @letter = Letter(letter)
    @accidental = Accidental(accidental)
  end

  def ==(other)
    equivalent_to?(other) || group.has?(other)
  end

  def equivalent_to?(other)
    if other.is_a?(self.class)
      letter == other.letter && accidental == other.accidental
    else
      [letter, accidental] == other
    end
  end

  def to_s
    if accidental == :natural
      letter.name.to_s.upcase
    else
      "%s%s" % [letter.name.upcase, accidental.symbol]
    end
  end

  def inspect
    StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
  end

  def pretty_print(pp)
    Util.pretty_print_without_object_id(
      self, pp,
      letter: letter,
      accidental: accidental
    )
  end

  private

  attr_reader :group
end
