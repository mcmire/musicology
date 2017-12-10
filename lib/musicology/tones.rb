require_relative "ring"
require_relative "tone"

module Musicology
  class << self
    attr_accessor :tones
  end

  self.tones = Ring.new(Tone, 0..11)

  def self.Tone(value)
    tones.find!(value)
  end
end
