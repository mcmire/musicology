module Musicology
  module BitwiseOperations
    def self.rotate(word, args)
      offset = args.fetch(:by)
      size = args.fetch(:with_size)

      if offset.positive?
        offset.times.reduce(word) { |w| rotate_right(w, size) }
      else
        offset.times.reduce(word) { |w| rotate_left(w, size) }
      end
    end

    def self.rotate_left(word, word_size)
      last_position = word_size - 1

      mask = (word << 1) & ~(1 << word_size)
      mask | ((mask & (1 << last_position)) >> last_position)
    end

    def self.rotate_right(word, word_size)
      last_position = word_size - 1

      (word >> 1) | (word[0] << last_position)
    end

    def self.rotationally_equivalent?(word1, word2, common_size:, i: 0)
      if word2 == word1
        false
      else
        rotated_word2 = rotate_right(word2, common_size)
        (
          rotated_word2 == word1 || (
            i < (common_size - 1) &&
            rotationally_equivalent?(
              word1,
              rotated_word2,
              common_size: common_size,
              i: i + 1,
            )
          )
        )
      end
    end
  end
end
