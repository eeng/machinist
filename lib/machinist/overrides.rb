module Machinist
  class Overrides
    def initialize lathe, attributes
      @lathe = lathe
      @attributes = attributes
    end

    def method_missing(attribute, *args, &block) #:nodoc:
      return unless @attributes.has_key?(attribute)
      @lathe.instance_exec @attributes[attribute], &block
    end
  end

  class OverridedAttributes
    def initialize
      @accumulator = Accumulator.new
    end

    def self.get_from &block
      new.tap { |oa| oa.instance_eval(&block) }.attributes
    end

    def method_missing(attribute, *args, &block) #:nodoc:
      return unless attribute.to_sym == :overrides
      @accumulator.instance_eval(&block)
    end

    def attributes
      @accumulator.attributes
    end

    class Accumulator
      attr_reader :attributes

      def initialize
        @attributes = []
      end

      def method_missing(attribute, *args, &block) #:nodoc:
        @attributes << attribute
      end
    end
  end
end
