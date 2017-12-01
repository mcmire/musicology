require_relative "note_names"

NoteSpellings = NoteNames.flat_map(&:spellings)
