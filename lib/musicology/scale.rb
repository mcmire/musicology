require_relative "heptatonic_scale"
require_relative "tones"

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

    def valid?
      root_tone_on? && !has_large_leaps?
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
      rotated_word = (word >> 1) | (word[0] << (NUMBER_OF_BITS - 1))
      self.class.new(rotated_word)
    end

    def rotation_of?(other, i = 0)
      rotated_version = rotate_right
      self != other && (
        rotated_version == other || (
          i < (NUMBER_OF_BITS - 1) &&
          rotated_version.rotation_of?(other, i + 1)
        )
      )
    end

    def equivalent_to?(other)
      other.is_a?(self.class) && (self == other || rotation_of?(other))
    end

    def ==(other)
      other.is_a?(self.class) && word == other.word
    end

    def scale(starting_on: Musicology.NoteSpelling(:c, :natural))
      HeptatonicScale.new(tones, starting_note: starting_on)
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
      ("%0#{NUMBER_OF_BITS}b" % word).split("").map { |bit| bit == "1" }.reverse
    end
  end
end
