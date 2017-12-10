require_relative "note_spelling"

class EquivalentNoteSpellingGroup
  attr_reader :spellings

  def initialize(spellings)
    @spellings = spellings.map do |(letter, accidental)|
      NoteSpelling.new(self, letter, accidental)
    end
  end

  def find!(letter_id = nil, &block)
    if block
      spelling = spellings.detect(&block)
    else
      letter = Letter(letter_id)
      spelling = spellings.detect { |s| s.letter == letter }
    end

    if spelling
      spelling
    else
      message =
        "Couldn't find spelling by #{letter_id.inspect}.\n" +
        "Valid spellings are: #{spellings}"
      raise ArgumentError, message
    end
  end

  def has?(given_spelling)
    spellings.any? { |spelling| spelling.equivalent_to?(given_spelling) }
  end

  def ==(value)
    if value.is_a?(self.class)
      spellings == value.spellings
    else
      has?(value)
    end
  end

  def to_s
    spellings.map(&:to_s).join(" / ")
  end

  def inspect
    StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
  end

  def pretty_print(pp)
    Util.pretty_print_without_object_id(self, pp, spellings: spellings)
  end
end
