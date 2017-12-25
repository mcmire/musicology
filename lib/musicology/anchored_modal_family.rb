module Musicology
  class AnchoredModalFamily
    attr_reader :scales

    def initialize(scales)
      @scales = scales
    end

    def has_note?(note)
      scales.first.has_note?(note)
    end

    def to_s
      scales.map { |scale| "* #{scale}" }.join("\n")
    end

    def inspect
      StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
    end

    def pretty_print(pp)
      Util.pretty_print_without_object_id(
        self,
        pp,
        scales: scales,
      )
    end
  end
end
