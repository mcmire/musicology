require_relative "ring"
require_relative "letter"

module Musicology
  Letters = Ring.new(Letter, :a..:g)

  def self.Letter(value)
    Letters.find!(value)
  end
end
