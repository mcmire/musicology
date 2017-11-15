require_relative "util"

module RingItemMethods
  attr_accessor :value, :ring, :index

  def +(offset)
    ring[index + offset]
  end

  def -(ring_item_or_offset)
    if ring_item_or_offset.is_a?(self.class)
      result = index - ring_item_or_offset.index

      if result.abs > (ring.size / 2)
        if ring_item_or_offset.index > index
          (index + ring.size) - ring_item_or_offset.index
        else
          index - (ring_item_or_offset.index + ring.size)
        end
      else
        result
      end
    else
      ring[index - ring_item_or_offset]
    end
  end

  # def method_missing(name, *args)
    # if value.respond_to?(name)
      # value.send(name, *args)
    # else
      # super
    # end
  # end

  # def respond_to_missing?(name, include_all)
    # value.respond_to?(name, include_all) || super
  # end

  def ==(other)
    if other.is_a?(self.class)
      value == other.value && index == other.index
    else
      super
    end
  end

  # def inspect
    # StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
  # end

  # alias_method :to_s, :inspect

  # def pretty_print(pp)
    # Util.pretty_print_without_object_id(self, pp, value: value, index: index)
  # end

  private

  attr_reader :ring
end
