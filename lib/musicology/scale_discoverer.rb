require_relative "modal_family_collection"
require_relative "util"

module Musicology
  class ScaleDiscoverer
    def self.call(note)
      new(note).call
    end

    def initialize(note)
      @note = note
    end

    def call
      popular_modal_families.reduce([], &method(:with_possible_match))
    end

    private

    attr_reader :note

    def popular_modal_families
      Musicology::ModalFamilyCollection.new.popular
    end

    def with_possible_match(matches, modal_family)
      possible_transpositions =
        determine_possible_transpositions_for(modal_family)
      matching_transpositions =
        find_matching_transpositions_from(possible_transpositions)

      if matching_transpositions.any?
        matches.concat(matching_transpositions)
      else
        matches
      end
    end

    def determine_possible_transpositions_for(modal_family)
      Musicology.notes.map { |note| modal_family.anchor_to(note) }
    end

    def find_matching_transpositions_from(anchored_modal_families)
      anchored_modal_families.select do |anchored_modal_family|
        anchored_modal_family.has_note?(note)
      end
    end

    class Match
      attr_reader :modal_families

      def initialize(anchored_modal_families)
        @modal_families = anchored_modal_families
      end

      def inspect
        StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
      end

      def pretty_print(pp)
        Util.pretty_print_without_object_id(
          self,
          pp,
          modal_families: modal_families,
        )
      end
    end
  end
end
