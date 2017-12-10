require "forwardable"
require_relative "ring_item_methods"

module Musicology
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

    def find!(*args)
      result =
        if args.size == 1
          case args.first
          when wrapper_class
            args.first
          when Integer
            items[args.first % size]
          else
            items.detect { |i| i == args.first }
          end
        else
          items.detect { |i| i == args }
        end

      if result
        result
      else
        message =
          "Couldn't find item by #{args.inspect}.\n" +
          "Valid items are:\n" +
          items.map { |item| "* #{item}" }.join("\n")
        raise ArgumentError.new(message)
      end
    end

    def inspect
      StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
    end

    def transpose_to(value)
      item = find!(value)
      values = items.rotate(item.index).map(&:value)
      self.class.new(wrapper_class, values)
    end

    alias_method :to_s, :inspect

    def pretty_print(pp)
      Util.pretty_print_without_object_id(self, pp, items: items)
    end

    private

    attr_reader :wrapper_class, :items
  end
end
