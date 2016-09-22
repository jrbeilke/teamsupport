require 'addressable/uri'
require 'teamsupport/arguments'
require 'teamsupport/rest/request'
require 'teamsupport/utils'
require 'uri'

module Teamsupport
  module REST
    module Utils
      include Teamsupport::Utils

    private

      # Take a URI string or Teamsupport::Identity object and return its ID
      #
      # @param object [Integer, String, URI, Teamsupport::Identity] An ID, URI, or object.
      #
      # @return [Integer]
      #
      # @api private
      def extract_id(object)
        case object
        when ::Integer
          object
        when ::String
          object.split('/').last.to_i
        when URI, Addressable::URI
          object.path.split('/').last.to_i
        when Teamsupport::Identity
          object.ID
        end
      end

      # Alias for performing HTTP GET request
      #
      # @param path [String]
      # @param options [Hash]
      #
      # @return [Array, Hash]
      #
      # @api private
      def perform_get(path, options = {})
        perform_request(:get, path, options)
      end

      # Alias for performing HTTP POST request
      #
      # @param path [String]
      # @param options [Hash]
      #
      # @return [Array, Hash]
      #
      # @api private
      def perform_post(path, options = {})
        perform_request(:post, path, options)
      end

      # Alias for performing HTTP PUT request
      #
      # @param path [String]
      # @param options [Hash]
      #
      # @return [Array, Hash]
      #
      # @api private
      def perform_put(path, options = {})
        perform_request(:put, path, options)
      end

      # Alias for performing HTTP DELETE request
      #
      # @param path [String]
      # @param options [Hash]
      #
      # @return [Array, Hash]
      #
      # @api private
      def perform_delete(path, options = {})
        perform_request(:delete, path, options)
      end

      # Create a new Teamsupport::REST::Request and perform an HTTP request
      #
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      #
      # @return [Array, Hash]
      #
      # @api private
      def perform_request(request_method, path, options = {})
        Teamsupport::REST::Request.new(self, request_method, path, options).perform
      end

      # Alias for performing HTTP GET request returning an object
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      #
      # @return [Object]
      #
      # @api private
      def perform_get_with_object(path, options, klass)
        perform_request_with_object(:get, path, options, klass)
      end

      # Alias for performing HTTP POST request returning an object
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      #
      # @return [Object]
      #
      # @api private
      def perform_post_with_object(path, options, klass)
        perform_request_with_object(:post, path, options, klass)
      end

      # Alias for performing HTTP PUT request returning an object
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      #
      # @return [Object]
      #
      # @api private
      def perform_put_with_object(path, options, klass)
        perform_request_with_object(:put, path, options, klass)
      end

      # Alias for performing HTTP requests returning an object
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      #
      # @return [Object]
      #
      # @api private
      def perform_request_with_object(request_method, path, options, klass)
        response = perform_request(request_method, path, options)
        klass.new(response)
      end

      # Alias for performing HTTP GET request returning an object from a collection
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param collection_name [Symbol]
      #
      # @return [Object]
      #
      # @api private
      def perform_get_with_object_from_collection(path, options, klass, collection_name)
        perform_request_with_object_from_collection(:get, path, options, klass, collection_name)
      end

      # Alias for performing HTTP POST request returning an object from a collection
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param collection_name [Symbol]
      #
      # @return [Object]
      #
      # @api private
      def perform_post_with_object_from_collection(path, options, klass, collection_name)
        perform_request_with_object_from_collection(:post, path, options, klass, collection_name)
      end

      # Alias for performing HTTP PUT request returning an object from a collection
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param collection_name [Symbol]
      #
      # @return [Object]
      #
      # @api private
      def perform_put_with_object_from_collection(path, options, klass, collection_name)
        perform_request_with_object_from_collection(:put, path, options, klass, collection_name)
      end

      # Alias for performing HTTP requests returning an object from a collection
      #
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param collection_name [Symbol]
      #
      # @return [Object]
      #
      # @api private
      def perform_request_with_object_from_collection(request_method, path, options, klass, collection_name) # rubocop:disable Metrics/ParameterLists
        options = {collection_name.to_sym => options} unless options.empty?

        response = perform_request(request_method, path, options).fetch(collection_name.to_sym)
        klass.new(response)
      end

      # Alias for performing HTTP GET request returning multiple objects
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      #
      # @return [Array]
      #
      # @api private
      def perform_get_with_objects(path, options, klass)
        perform_request_with_objects(:get, path, options, klass)
      end

      # Alias for performing HTTP POST request returning multiple objects
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      #
      # @return [Array]
      #
      # @api private
      def perform_post_with_objects(path, options, klass)
        perform_request_with_objects(:post, path, options, klass)
      end

      # Alias for performing HTTP PUT request returning multiple objects
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      #
      # @return [Array]
      #
      # @api private
      def perform_put_with_objects(path, options, klass)
        perform_request_with_objects(:put, path, options, klass)
      end

      # Alias for performing HTTP requests returning multiple objects
      #
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      #
      # @return [Array]
      #
      # @api private
      def perform_request_with_objects(request_method, path, options, klass)
        perform_request(request_method, path, options).collect do |element|
          klass.new(element)
        end
      end

      # Alias for performing HTTP GET request returning multiple objects in a collection
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param collection_name [Symbol]
      #
      # @return [Array]
      #
      # @api private
      def perform_get_with_objects_from_collection(path, options, klass, collection_name)
        perform_request_with_objects_from_collection(:get, path, options, klass, collection_name)
      end

      # Alias for performing HTTP POST request returning multiple objects in a collection
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param collection_name [Symbol]
      #
      # @return [Array]
      #
      # @api private
      def perform_post_with_objects_from_collection(path, options, klass, collection_name)
        perform_request_with_objects_from_collection(:post, path, options, klass, collection_name)
      end

      # Alias for performing HTTP PUT request returning multiple objects in a collection
      #
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param collection_name [Symbol]
      #
      # @return [Array]
      #
      # @api private
      def perform_put_with_objects_from_collection(path, options, klass, collection_name)
        perform_request_with_objects_from_collection(:put, path, options, klass, collection_name)
      end

      # Alias for performing HTTP requests returning multiple objects in a collection
      #
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param collection_name [Symbol]
      #
      # @return [Array]
      #
      # @api private
      def perform_request_with_objects_from_collection(request_method, path, options, klass, collection_name) # rubocop:disable Metrics/ParameterLists
        options = {collection_name.to_sym => options} unless options.empty?

        perform_request(request_method, path, options).fetch(collection_name.to_sym).collect do |element|
          klass.new(element)
        end
      end
    end
  end
end
