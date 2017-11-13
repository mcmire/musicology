class HeptatonicScaleGenerator
  NUMBER_OF_TONES = 12
  HALF_INTERVAL = 1
  WHOLE_INTERVAL = 2

  def call
    scale = [0]

    6.times.each do
      random_interval = [HALF_INTERVAL, WHOLE_INTERVAL].sample
      scale << scale.last + random_interval
    end

    scale
  end
end
