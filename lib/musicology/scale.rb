require_relative "anchored_scale"
require_relative "named_scales"
require_relative "notes"
require_relative "tones"
require_relative "bitwise_operations"

module Musicology
  class Scale
    NUMBER_OF_BITS = 12
    MAXIMUM = (2 ** NUMBER_OF_BITS) - 1
    MAJOR_THIRD = 4

    attr_reader :word

    def initialize(word)
      if word > MAXIMUM
        raise ArgumentError, "Given scale must be 12 tones"
      end

      @word = word
    end

    def names
      NAMED_SCALES.fetch(word, [])
    end

    def default_name
      names.first || ""
    end

    def popular?
      POPULAR_SCALES.include?(word)
    end

    def valid?
      root_tone_on? && !has_large_leaps?
    end

    def anchor_to(note)
      AnchoredScale.new(self, note)
    end

    def notes(starting_on: Musicology.NoteSpelling(:c, :natural))
      anchor_to(starting_on).notes
    end

    def tones
      bits.
        each_with_index.
        select { |bit, _| bit }.
        map { |_, tone| Musicology.Tone(tone) }
    end

    def modes
      (NUMBER_OF_BITS - 2).times.
        reduce([rotate_right]) { |array| array << array.last.rotate_right }.
        select(&:valid?)
    end

    def rotate_right
      self.class.new(rotate_word_by(1))
    end

    def rotation_of?(other)
      BitwiseOperations.rotationally_equivalent?(
        word,
        other.word,
        common_size: NUMBER_OF_BITS,
      )
    end

    def equivalent_to?(other)
      other.is_a?(self.class) && (self == other || rotation_of?(other))
    end

    def ==(other)
      other.is_a?(self.class) && word == other.word
    end

    def inspect
      StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
    end

    def pretty_print(pp)
      Util.pretty_print_without_object_id(
        self,
        pp,
        name: name,
        word: word,
        word_string: word_string,
        tones: tones,
      )
    end

    private

    def root_tone_on?
      !!bits.first
    end

    def has_large_leaps?
      intervals.any? { |interval| interval > MAJOR_THIRD }
    end

    def interval_inventory
      intervals.reduce(Hash.new(0)) do |inventory, interval|
        inventory.merge(interval => inventory[interval] + 1)
      end
    end

    def intervals
      (tones + [tones.first]).each_cons(2).map { |a, b| b - a }
    end

    def bits
      word_string.split("").map { |bit| bit == "1" }.reverse
    end

    def word_string
      "%0#{NUMBER_OF_BITS}b" % word
    end

    def rotate_word_by(offset)
      BitwiseOperations.rotate(
        word,
        with_size: NUMBER_OF_BITS,
        by: offset,
      )
    end
  end
end
