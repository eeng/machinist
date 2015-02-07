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
    attr_reader :assigned_attributes

    def initialize attributes
      @accumulator = Accumulator.new
      @assigned_attributes = attributes
    end

    def self.get_from attributes, &block
      new(attributes).tap { |oa| oa.instance_eval(&block) }.attributes
    end

    def method_missing(attribute, *args, &block) #:nodoc:
      return unless attribute.to_sym == :overrides
      @accumulator.instance_exec(@assigned_attributes, &block)
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
