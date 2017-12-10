require_relative "ring"
require_relative "letter"

module Musicology
  class << self
    attr_accessor :letters
  end

  self.letters = Ring.new(Letter, :a..:g)

  def self.Letter(value)
    letters.find!(value)
  end
end
