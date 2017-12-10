require_relative "heptatonic_scale"
require_relative "simple_note_spellings"
require_relative "tones"

module Musicology
  class HeptatonicScaleGenerator
    def self.call
      new.call
    end

    HALF_INTERVAL = 1
    WHOLE_INTERVAL = 2

    def call
      HeptatonicScale.new(
        tones,
        starting_note: Musicology.simple_note_spellings.sample,
      )
    end

    private

    def tones
      6.times.reduce([Musicology.Tone(0)]) do |scale|
        random_interval = [HALF_INTERVAL, WHOLE_INTERVAL].sample
        scale << (scale.last + random_interval)
      end
    end
  end
end
