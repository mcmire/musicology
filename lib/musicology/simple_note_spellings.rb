require_relative "note_names"

module Musicology
  class << self
    attr_accessor :simple_note_spellings
  end

  self.simple_note_spellings = note_names.flat_map(&:spellings).select do |s|
    s.accidental == :flat || s.accidental == :natural || s.accidental == :sharp
  end
end
