class Accidental
  attr_reader :name, :offset, :symbol

  def initialize(accidentals, name:, offset:, symbol:)
    @accidentals = accidentals
    @name = name
    @offset = offset
    @symbol = symbol
  end

  def +(offset)
    accidentals[self.offset + offset]
  end

  def -(offset)
    accidentals[self.offset - offset]
  end

  def inspect
    StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
  end

  alias_method :to_s, :inspect

  def pretty_print(pp)
    Util.pretty_print_without_object_id(
      self,
      pp,
      name: name,
      offset: offset,
      symbol: symbol,
    )
  end

  private

  attr_reader :accidentals
end
