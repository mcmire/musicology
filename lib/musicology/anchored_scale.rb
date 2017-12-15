require_relative "scale_note"
require_relative "note_names"

module Musicology
  class AnchoredScale
    def initialize(scale, anchor)
      @scale = scale
      @anchor = anchor
      @available_note_names = Musicology.note_names.transpose_to(anchor)
    end

    def note_names
      notes.map { |note| note.spelling.to_s }
    end

    def notes
      tones_and_intervals.reduce([]) do |notes_so_far, (tone, interval)|
        if tone == 0
          notes_so_far << ScaleNote.new(anchor, tone)
        else
          note_name = available_note_names.find!(tone.index)
          note_spelling = spell_note(note_name, interval, notes_so_far)
          notes_so_far << ScaleNote.new(note_spelling, tone)
        end
      end
    end

    private

    attr_reader :scale, :anchor, :available_note_names

    def tones
      scale.tones
    end

    def tones_and_intervals
      ([nil] + tones).each_cons(2).map do |a, b|
        if a == nil
          [b, nil]
        else
          [b, b - a]
        end
      end
    end

    def spell_note(note_name, interval, notes_so_far)
      last_letter = notes_so_far.last.spelling.letter
      note_spelling = nil

      if tones.size == 7 && last_letter + 1 != anchor.letter
        note_spelling ||= note_name.spellings.detect do |spelling|
          spelling.letter == last_letter + 1
        end
      end

      note_spelling ||= note_name.spellings.detect do |spelling|
        spelling.letter == last_letter + (interval / 2.0).floor
      end

      note_spelling ||= note_name.spellings.detect do |spelling|
        spelling.letter == last_letter + (interval / 2.0).ceil
      end

      if note_spelling && note_spelling.kind_of_flat? && notes_so_far.any?(&:kind_of_sharp?)
        note_spelling = note_name.spellings.detect(&:kind_of_sharp?)
      end

      if note_spelling && note_spelling.kind_of_sharp? && notes_so_far.any?(&:kind_of_flat?)
        (note_spelling.kind_of_sharp? && notes_so_far.any?(&:kind_of_sharp?))
      end

      note_spelling ||= note_name.spellings.first

      note_spelling
    end
  end
end
