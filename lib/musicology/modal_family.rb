require_relative "anchored_modal_family"

module Musicology
  class ModalFamily
    attr_reader :scales

    def initialize(scales)
      @scales = scales
    end

    def anchor_to(note_or_note_spelling)
      anchored_scale = scales.first.anchor_to(note_or_note_spelling)
      AnchoredModalFamily.new([anchored_scale] + anchored_scale.modes)
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
