require_relative "accidental_collection"

module Musicology
  ACCIDENTALS = AccidentalCollection.new([
    { name: :double_flat, offset: -2, symbol: "𝄫" },
    { name: :flat, offset: -1, symbol: "♭" },
    { name: :natural, offset: 0, symbol: "♮" },
    { name: :sharp, offset: 1, symbol: "♯" },
    { name: :double_sharp, offset: 2, symbol: "𝄪" },
  ])

  def self.accidentals
    ACCIDENTALS
  end

  def self.Accidental(value)
    accidentals.find!(value)
  end
end
