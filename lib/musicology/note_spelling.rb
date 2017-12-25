require_relative "accidentals"
require_relative "letters"

module Musicology
  class NoteSpelling
    attr_reader :note, :letter, :accidental

    def initialize(note, letter, accidental)
      @note = note
      @letter = Musicology.Letter(letter)
      @accidental = Musicology.Accidental(accidental)
    end

    def kind_of_flat?
      accidental == :flat || accidental == :double_flat
    end

    def natural?
      accidental == :natural
    end

    def sharp?
      accidental == :sharp
    end

    def kind_of_sharp?
      sharp? || accidental == :double_sharp
    end

    def ==(other)
      equivalent_to?(other) || note.has_spelling?(other)
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
  end
end
