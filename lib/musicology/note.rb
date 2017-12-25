require_relative "note_spelling"
require_relative "letters"

module Musicology
  class Note
    attr_reader :spellings

    def initialize(spellings)
      @spellings = spellings.map do |(letter, accidental)|
        NoteSpelling.new(self, letter, accidental)
      end
    end

    def default_name
      default_spelling.to_s
    end

    def default_letter
      default_spelling.letter
    end

    def find_spelling!(letter_id = nil, &block)
      if block
        spelling = spellings.detect(&block)
      else
        letter = Musicology.Letter(letter_id)
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

    def has_spelling?(given_spelling)
      spellings.any? { |spelling| spelling.equivalent_to?(given_spelling) }
    end

    def ==(value)
      if value.is_a?(self.class)
        spellings == value.spellings
      else
        has_spelling?(value)
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

    private

    def default_spelling
      spellings.detect(&:natural?) || spellings.detect(&:sharp?)
    end
  end
end
