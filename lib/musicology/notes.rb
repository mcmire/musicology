require_relative "ring"
require_relative "note"

module Musicology
  NOTES = Ring.new(Note, [
    [[:b, :sharp], [:c, :natural], [:d, :double_flat]],
    [[:b, :double_sharp], [:c, :sharp], [:d, :flat]],
    [[:c, :double_sharp], [:d, :natural], [:e, :double_flat]],
    [[:d, :sharp], [:e, :flat], [:f, :double_sharp]],
    [[:d, :double_sharp], [:e, :natural], [:f, :flat]],
    [[:e, :sharp], [:f, :natural], [:g, :double_flat]],
    [[:e, :double_sharp], [:f, :sharp], [:g, :flat]],
    [[:f, :double_sharp], [:g, :natural], [:a, :double_flat]],
    [[:g, :sharp], [:a, :flat]],
    [[:g, :double_sharp], [:a, :natural], [:b, :double_flat]],
    [[:a, :sharp], [:b, :flat], [:c, :double_flat]],
    [[:a, :double_sharp], [:b, :natural], [:c, :flat]],
  ])

  def self.notes
    NOTES
  end

  def self.Note(letter, accidental)
    notes.find!(letter, accidental)
  end

  def self.NoteSpelling(letter, accidental)
    Note(letter, accidental).find_spelling!(letter)
  end
end
