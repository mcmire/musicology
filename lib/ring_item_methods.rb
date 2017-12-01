require_relative "util"

module RingItemMethods
  attr_accessor :value, :ring, :index

  def +(offset)
    ring.find!(index + offset)
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
      ring.find!(index - ring_item_or_offset)
    end
  end

  def ==(other)
    if other.is_a?(self.class)
      value == other.value && index == other.index
    else
      super
    end
  end
end
