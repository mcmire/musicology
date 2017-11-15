require "spec_helper"
require_relative "../lib/white_key_collection"
require_relative "../lib/note"

describe WhiteKeyCollection do
  describe "#transpose_to" do
    it "returns a WhiteKeyCollection which is transposed by the given note" do
      old_collection = described_class.new([
        { letter: :c, tone: 0 },
        { letter: :d, tone: 2 },
        { letter: :e, tone: 4 },
        { letter: :f, tone: 5 },
        { letter: :g, tone: 7 },
        { letter: :a, tone: 9 },
        { letter: :b, tone: 11 },
      ])
      old_collection_contents = old_collection.map do |white_key|
        [white_key.letter, white_key.tone, white_key.index]
      end
      expect(old_collection_contents).to eq([
        [:c, 0, 0],
        [:d, 2, 1],
        [:e, 4, 2],
        [:f, 5, 3],
        [:g, 7, 4],
        [:a, 9, 5],
        [:b, 11, 6],
      ])

      new_collection = old_collection.transpose_to(Note.new(:f, :sharp))

      new_collection_contents = new_collection.map do |white_key|
        [white_key.letter, white_key.tone, white_key.index]
      end
      expect(new_collection_contents).to eq([
        [:g, 1, 0],
        [:a, 3, 1],
        [:b, 5, 2],
        [:c, 6, 3],
        [:d, 8, 4],
        [:e, 10, 5],
        [:f, 11, 6],
      ])
    end
  end
end
