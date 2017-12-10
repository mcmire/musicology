require_relative "note_names"

SimpleNoteSpellings = NoteNames.flat_map(&:spellings).select do |spelling|
  spelling.accidental == :flat ||
    spelling.accidental == :natural ||
    spelling.accidental == :sharp
end
