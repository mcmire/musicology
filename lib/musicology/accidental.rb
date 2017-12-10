require_relative "util"

module Musicology
  class Accidental
    attr_reader :name, :offset, :symbol

    def initialize(accidentals, name, offset, symbol)
      @accidentals = accidentals
      @name = name
      @offset = offset
      @symbol = symbol
    end

    def +(offset)
      accidentals.find!(self.offset + offset)
    end

    def -(offset)
      accidentals.find!(self.offset - offset)
    end

    def ==(value)
      case value
      when self.class
        name == value.name && offset == value.offset && symbol == value.symbol
      else
        name == value || symbol == value || offset == value
      end
    end

    def to_s
      "#<#{self.class} #{symbol}>"
    end

    def inspect
      StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
    end

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

  def self.Accidental(value)
    Accidentals.find!(value)
  end
end
