require "forwardable"
require_relative "accidental"

class AccidentalCollection
  include Enumerable
  extend Forwardable

  def_delegators :list, :each, :sample

  def initialize(accidental_specs)
    @list = accidental_specs.map do |accidental_spec|
      Accidental.new(self, **accidental_spec)
    end

    @list_by_name = list.reduce({}) do |hash, accidental|
      hash.merge(accidental.name => accidental)
    end

    @list_by_offset = list.reduce({}) do |hash, accidental|
      hash.merge(accidental.offset => accidental)
    end
  end

  def [](value)
    case value
    when Symbol
      list_by_name.fetch(value)
    when Integer
      list_by_offset.fetch(value)
    when Accidental
      value
    else
      raise ArgumentError, "Couldn't find accidental by #{value.inspect}"
    end
  end

  private

  attr_reader :list, :list_by_name, :list_by_offset
end
