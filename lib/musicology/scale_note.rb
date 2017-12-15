require "forwardable"

require_relative "tones"

module Musicology
  class ScaleNote
    extend Forwardable

    attr_reader :spelling, :tone

    def_delegators :spelling, :kind_of_flat?, :natural?, :kind_of_sharp?

    def initialize(spelling, tone)
      @spelling = spelling
      @tone = Musicology.Tone(tone)
    end

    def name
      spelling.to_s
    end

    def ==(other)
      other.is_a?(self.class) &&
        spelling == other.spelling &&
        tone == other.tone
    end

    def to_s
      "%s (%d)" % [spelling.to_s, tone]
    end

    def inspect
      "#<%s %s>" % [self.class, to_s]
    end
  end
end
