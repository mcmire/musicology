require "forwardable"
require_relative "ring_item_methods"

class Ring
  include Enumerable
  extend Forwardable

  def_delegators :items, :size, :sample, :each

  def initialize(wrapper_class, values)
    @wrapper_class = wrapper_class

    @items = values.map.with_index do |value, index|
      if value.is_a?(wrapper_class)
        value
      else
        wrapper_class.new(value).extend(RingItemMethods).tap do |item|
          item.ring = self
          item.value = value
          item.index = index
        end
      end
    end
  end

  def at(index)
    items[index % size]
  end

  def [](value_or_index)
    result =
      case value_or_index
      when wrapper_class
        value_or_index
      when Integer
        items[value_or_index % size]
      else
        items.detect { |i| i == value_or_index }
      end

    if result
      result
    else
      message =
        "Couldn't find item by #{value_or_index.inspect}. " +
        "Valid items are: #{items.inspect}"
      raise ArgumentError.new(message)
    end
  end

  def inspect
    StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
  end

  alias_method :to_s, :inspect

  def pretty_print(pp)
    Util.pretty_print_without_object_id(self, pp, items: items)
  end

  private

  attr_reader :wrapper_class, :items
end
