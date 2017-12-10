module Musicology
  class Tone < SimpleDelegator
    def to_i
      __getobj__
    end
  end
end
