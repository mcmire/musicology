require "spec_helper"
require_relative "../../lib/musicology/acoustics"

describe Musicology::Acoustics do
  describe "#harmonic_series" do
    it "returns the first N numbers in the series starting on a frequency" do
      acoustics = described_class.new(440)

      series = acoustics.harmonic_series(5)

      expect(series).to eq([440, 880, 1320, 1760, 2200])
    end
  end

  describe "#normalized_harmonic_series" do
    it "returns the harmonic series fit within an octave along with their relationships to the fundamental" do
      acoustics = described_class.new(440)

      series = acoustics.normalized_harmonic_series(5)

      expect(series).to eq([
        { frequency: 440.0, ratio: Rational(1, 1) },
        { frequency: 550.0, ratio: Rational(5, 4) },
        { frequency: 660.0, ratio: Rational(3, 2) },
        { frequency: 880.0, ratio: Rational(2, 1) },
      ])
    end
  end

  describe "#interval_to_frequencies" do
    it "returns the frequencies that represent the interval anchored at the fundamental frequency" do
      acoustics = described_class.new(440)

      frequencies = acoustics.interval_to_frequencies(Rational(9, 8))

      expect(frequencies).to eq([440, 495])
    end
  end
end
