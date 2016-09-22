require 'addressable/uri'
require 'forwardable'
require 'teamsupport/null_object'
require 'teamsupport/utils'

module Teamsupport
  class Base
    extend Forwardable
    include Teamsupport::Utils
    # Provide an attrs method for reading object attributes
    #
    # @example
    #   teamsupport_object = Teamsupport::Base.new(ID: 1)
    #   teamsupport_object.attrs[:ID]
    #
    # @return [Hash]
    #
    # @api public
    attr_reader :attrs
    alias to_h attrs
    alias to_hash to_h

    class << self
      # Define methods for reading and checking existence of attributes
      #
      # @example
      #   attr_reader :attrs
      #
      # @param attrs [Array, Symbol]
      #
      # @return [Object, Boolean, nil]
      #
      # @api public
      def attr_reader(*attrs)
        attrs.each do |attr|
          define_attribute_method(attr)
          define_predicate_method(attr)
        end
      end

      # Define methods for checking existence of attributes
      #
      # @example
      #   predicate_attr_reader :favorited
      #
      # @return [Boolean]
      #
      # @api public
      def predicate_attr_reader(*attrs)
        attrs.each do |attr|
          define_predicate_method(attr)
        end
      end

      # Define methods for reading and checking existence of attributes within an object
      #
      # @example
      #   object_attr_reader :User, :user, :status
      #
      # @param klass [Symbol]
      # @param key1 [Symbol]
      # @param key2 [Symbol]
      #
      # @return [Object, Boolean, nil]
      #
      # @api public
      def object_attr_reader(klass, key1, key2 = nil)
        define_attribute_method(key1, klass, key2)
        define_predicate_method(key1)
      end

      # Dynamically define a method for getting the value of an attribute
      #
      # @example
      #   define_attribute_method(key1, klass, key2)
      #
      # @param key1 [Symbol]
      # @param klass [Symbol]
      # @param key2 [Symbol]
      #
      # @return [Object, nil]
      #
      # @api public
      def define_attribute_method(key1, klass = nil, key2 = nil)
        define_method(key1) do
          if attr_falsey_or_empty?(key1)
            NullObject.new
          else
            klass.nil? ? @attrs[key1] : Teamsupport.const_get(klass).new(attrs_for_object(key1, key2))
          end
        end
      end

      # Dynamically define a method for checking existence of an attribute
      #
      # @example
      #   define_predicate_method(key1)
      #
      # @param key1 [Symbol]
      # @param key2 [Symbol]
      #
      # @return [Boolean]
      #
      # @api public
      def define_predicate_method(key1, key2 = key1)
        define_method(:"#{key1}?") do
          !attr_falsey_or_empty?(key2)
        end
      end
    end

    # Initializes a new object
    #
    # @param attrs [Hash]
    #
    # @return [Teamsupport::Base]
    #
    # @api private
    def initialize(attrs = {})
      @attrs = attrs || {}
    end

    # Fetches an attribute of an object using hash notation
    #
    # @example
    #   teamsupport_object = Teamsupport::Base.new(ID: 1)
    #   teamsupport_object[:ID]
    #
    # @param method [String, Symbol] Message to send to the object
    #
    # @return [String, nil]
    #
    # @api public
    #
    # @deprecated Please use ##{method} to fetch the value instead
    def [](method)
      warn "#{Kernel.caller.first}: [DEPRECATION] #[#{method.inspect}] is deprecated. Use ##{method} to fetch the value."
      send(method.to_sym)
    rescue NoMethodError
      nil
    end

  private

    # Check to see if the value for an object attribute is falsey or empty
    #
    # @param key [Symbol]
    #
    # @return [Boolean]
    #
    # @api private
    def attr_falsey_or_empty?(key)
      !@attrs[key] || @attrs[key].respond_to?(:empty?) && @attrs[key].empty?
    end

    # Fetch and/or update the attributes for an object
    #
    # @param key1 [Symbol]
    # @param key2 [Symbol]
    #
    # @return [Hash]
    #
    # @api private
    def attrs_for_object(key1, key2 = nil)
      if key2.nil?
        @attrs[key1]
      else
        attrs = @attrs.dup
        attrs.delete(key1).merge(key2 => attrs)
      end
    end
  end
end
