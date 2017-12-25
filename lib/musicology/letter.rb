require_relative "util"

module Musicology
  class Letter < SimpleDelegator
    def name
      __getobj__
    end

    def to_s
      "#<#{self.class} #{name.upcase}>"
    end

    def inspect
      StringIO.new.tap { |io| PP.singleline_pp(self, io) }.string
    end

    def pretty_print(pp)
      pp.object_group(self) do
        pp.breakable(" ")
        pp.pp(name)
      end
    end
  end
end
