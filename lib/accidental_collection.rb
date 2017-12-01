require "forwardable"
require_relative "accidental"
require_relative "errors"

class AccidentalCollection
  include Enumerable
  extend Forwardable

  def_delegators :list, :each, :sample

  def initialize(accidental_specs)
    @list = accidental_specs.map do |name:, offset:, symbol:|
      Accidental.new(self, name, offset, symbol)
    end
  end

  def find!(value)
    accidental = list.detect { |a| a == value }

    if accidental
      accidental
    else
      raise AccidentalNotFoundError.create(value: value)
    end
  end

  private

  attr_reader :list
end
