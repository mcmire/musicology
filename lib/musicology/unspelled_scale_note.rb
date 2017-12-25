require "forwardable"

require_relative "tones"

module Musicology
  class UnspelledScaleNote
    extend Forwardable

    attr_reader :note, :tone

    def initialize(note, tone)
      @note = note
      @tone = Musicology.Tone(tone)
    end

    def name_source
      note
    end

    def name
      note.default_name
    end

    def letter
      note.default_letter
    end

    def ==(other)
      other.is_a?(self.class) &&
        note == other.note &&
        tone == other.tone
    end

    def to_s
      "%s (%d)" % [note.to_s, tone]
    end

    def inspect
      "#<%s %s>" % [self.class, to_s]
    end
  end
end
