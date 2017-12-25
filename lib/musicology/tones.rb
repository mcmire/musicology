require_relative "ring"
require_relative "tone"

module Musicology
  TONES = Ring.new(Tone, 0..11)

  def self.tones
    TONES
  end

  def self.Tone(value)
    tones.find!(value)
  end
end
