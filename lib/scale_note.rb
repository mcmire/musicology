require_relative "note"

class ScaleNote < Note
  def to_s
    symbol = accidental.symbol
    string = white_key.letter.to_s.upcase

    if accidental.name != :natural
      string << symbol
    end

    string
  end

  alias_method :inspect, :to_s
end
