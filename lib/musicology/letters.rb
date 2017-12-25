require_relative "ring"
require_relative "letter"

module Musicology
  LETTERS = Ring.new(Letter, :a..:g)

  def self.letters
    LETTERS
  end

  def self.Letter(value)
    letters.find!(value)
  end
end
