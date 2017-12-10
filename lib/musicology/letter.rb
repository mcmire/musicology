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
      Util.pretty_print_without_object_id(self, pp, name: name)
    end
  end
end
