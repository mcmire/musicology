module Musicology
  class Error < StandardError
    def self.create(args)
      allocate.tap do |error|
        args.each do |key, value|
          error.public_send("#{key}=", value)
        end

        error.send(:initialize, error.send(:build_message))
      end
    end

    private_class_method :new
  end

  class AccidentalNotFoundError < Error
    attr_accessor :value

    private

    def build_message
      "Couldn't find accidental by #{value.inspect}"
    end
  end
end
