require_relative "note_names"
require_relative "tones"

class ScaleNote
  attr_reader :spelling, :tone

  def initialize(spelling, tone)
    @spelling = spelling
    @tone = Tone(tone)
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
