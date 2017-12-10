require_relative "ring"
require_relative "tone"

module Musicology
  Tones = Ring.new(Tone, 0..11)

  def self.Tone(value)
    Tones.find!(value)
  end
end
