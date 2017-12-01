require_relative "ring"
require_relative "tone"

Tones = Ring.new(Tone, 0..11)

def Tone(value)
  Tones.find!(value)
end
