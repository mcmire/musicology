class Tone
  MAXIMUM = 12

  attr_reader :index

  def initialize(index)
    @index = index % MAXIMUM
  end

  def +(offset)
    new(index + offset)
  end

  def -(offset)
    new(index - offset)
  end

  def ==(other)
    other.is_a?(self.class) && index == other.index
  end

  def to_s
    "#<Tone index: #{index}>"
  end

  alias_method :inspect, :to_s
end
