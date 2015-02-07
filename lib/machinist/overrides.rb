module Machinist
  class OverridedAttributes    
    attr_reader :assigned_attributes

    def initialize object, attributes
      @accumulator = Accumulator.new object
      @assigned_attributes = attributes
    end

    def self.get_from object, attributes, &block
      new(object, attributes).tap { |oa| oa.instance_eval(&block) }
    end

    def method_missing(attribute, *args, &block) #:nodoc:
      return unless attribute.to_sym == :overrides
      @accumulator.instance_exec(@assigned_attributes, &block)
    end

    def attributes
      @accumulator.attributes
    end

    class Accumulator
      attr_reader :attributes, :object

      def initialize object
        @attributes = []
        @object = object
      end

      def method_missing(attribute, *args, &block) #:nodoc:
        @attributes << attribute
      end
    end
  end
end
