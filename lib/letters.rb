require_relative "ring"
require_relative "letter"

Letters = Ring.new(Letter, :a..:g)

def Letter(value)
  Letters.find!(value)
end
