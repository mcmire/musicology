require_relative "heptatonic_scale"
require_relative "note"
require_relative "tones"

class HeptatonicScaleGenerator
  HALF_INTERVAL = 1
  WHOLE_INTERVAL = 2

  def call
    HeptatonicScale.new(tones, starting_note: Note.random)
  end

  private

  def tones
    6.times.reduce([Tones[0]]) do |scale|
      random_interval = [HALF_INTERVAL, WHOLE_INTERVAL].sample
      scale << (scale.last + random_interval)
    end
  end
end
