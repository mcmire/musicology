module Musicology
  class Acoustics
    def initialize(fundamental_frequency)
      @fundamental_frequency = fundamental_frequency.to_f
    end

    def harmonic_series(number)
      Array.new(number) { |i| fundamental_frequency * (i + 1) }
    end

    def normalized_harmonic_series(number)
      harmonic_series(number).
        map { |frequency| normalize(frequency) }.
        sort.
        uniq.
        map { |frequency|
          {
            frequency: frequency,
            ratio: Rational(frequency, fundamental_frequency),
          }
        }
    end

    def interval_to_frequencies(interval)
      [
        fundamental_frequency,
        (fundamental_frequency * interval).to_f,
      ]
    end

    private

    attr_reader :fundamental_frequency

    def normalize(frequency)
      if frequency <= fundamental_frequency * 2
        frequency
      else
        normalize(frequency / 2.0)
      end
    end
  end
end
