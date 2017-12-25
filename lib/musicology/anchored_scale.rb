require "forwardable"
require_relative "notes"
require_relative "spelled_scale_note"
require_relative "unspelled_scale_note"

module Musicology
  class AnchoredScale
    extend Forwardable

    def_delegators :scale, :word, :names, :default_name

    attr_reader :anchor

    def initialize(scale, anchor)
      @scale = scale
      @anchor = anchor
      @available_notes = Musicology.notes.transpose_to(anchor)
    end

    def note_names
      notes.map { |note| note.name_source.to_s }
    end

    def notes
      if anchor.is_a?(Note)
        tones_and_intervals.map do |tone, _|
          note = available_notes.find!(tone.index)
          UnspelledScaleNote.new(note, tone)
        end
      else
        tones_and_intervals.reduce([]) do |notes_so_far, (tone, interval)|
          if tone == 0
            notes_so_far << SpelledScaleNote.new(anchor, tone)
          else
            note = available_notes.find!(tone.index)
            note_spelling = spell_note(note, interval, notes_so_far)
            notes_so_far << SpelledScaleNote.new(note_spelling, tone)
          end
        end
      end
    end

    def has_note?(given_note)
      notes.any? { |scale_note| scale_note.note == given_note }
    end

    def modes
      scale.modes.zip(notes[1..-1]).map do |mode, scale_note|
        self.class.new(mode, scale_note.name_source)
      end
    end

    def to_s
      "#{default_name}: #{note_names}"
    end

    def inspect
      StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
    end

    def pretty_print(pp)
      Util.pretty_print_without_object_id(
        self,
        pp,
        scale: scale,
        anchor: anchor,
      )
    end

    private

    attr_reader :scale, :available_notes

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

    def spell_note(note, interval, notes_so_far)
      last_letter = notes_so_far.last.letter
      note_spelling = nil

      if tones.size == 7 && last_letter + 1 != anchor.letter
        note_spelling ||= note.spellings.detect do |spelling|
          spelling.letter == last_letter + 1
        end
      end

      note_spelling ||= note.spellings.detect do |spelling|
        spelling.letter == last_letter + (interval / 2.0).floor
      end

      note_spelling ||= note.spellings.detect do |spelling|
        spelling.letter == last_letter + (interval / 2.0).ceil
      end

      if note_spelling && note_spelling.kind_of_flat? && notes_so_far.any?(&:kind_of_sharp?)
        note_spelling = note.spellings.detect(&:kind_of_sharp?)
      end

      if note_spelling && note_spelling.kind_of_sharp? && notes_so_far.any?(&:kind_of_flat?)
        note_spelling = note.spellings.detect(&:kind_of_flat?)
      end

      note_spelling ||= note.spellings.first

      note_spelling
    end
  end
end
