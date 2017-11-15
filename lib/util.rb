require "pp"

module Util
  def self.pretty_print(object, pp, properties)
    pp.object_address_group(object) do
      pp.breakable(" ")
      pp.seplist(properties, nil, :each_pair) do |key, value|
        pp.group do
          pp.text(key.to_s)
          pp.text(":")
          pp.group(1) do
            pp.breakable(" ")
            pp.pp(value)
          end
        end
      end
    end
  end

  def self.pretty_print_without_object_id(object, pp, properties)
    pp.object_group(object) do
      pp.breakable(" ")
      pp.seplist(properties, nil, :each_pair) do |key, value|
        pp.group do
          pp.text(key.to_s)
          pp.text(":")
          pp.group(1) do
            pp.breakable(" ")
            pp.pp(value)
          end
        end
      end
    end
  end
end
