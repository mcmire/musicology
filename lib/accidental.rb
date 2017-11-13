module Accidental
  def self.flat
    Flat.new
  end

  def self.natural
    Natural.new
  end

  def self.sharp
    Sharp.new
  end

  class Flat
    def to_s
      "♭"
    end
  end

  class Natural
    def to_s
      "♮"
    end
  end

  class Sharp
    def to_s
      "♯"
    end
  end
end
