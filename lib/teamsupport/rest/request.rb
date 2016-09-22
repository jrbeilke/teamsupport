require 'addressable/uri'
require 'http'
require 'http/form_data'
require 'json'
require 'openssl'
require 'teamsupport/error'
require 'teamsupport/headers'

module Teamsupport
  module REST
    class Request
      BASE_URL = 'https://app.teamsupport.com'.freeze
      attr_accessor :client, :headers, :options, :path, :request_method, :uri
      alias verb request_method

      # Initialize a new REST Request object
      #
      # @param client [Teamsupport::Client]
      # @param request_method [String, Symbol]
      # @param path [String]
      # @param options [Hash]
      #
      # @return [Teamsupport::REST::Request]
      #
      # @api private
      def initialize(client, request_method, path, options = {})
        @client = client
        @uri = Addressable::URI.parse(path.start_with?('http') ? path : BASE_URL + path)
        @request_method = request_method
        @headers = Teamsupport::Headers.new(@client, @request_method, @uri, options).request_headers
        @path = uri.path
        @options = options
      end

      # Perform an HTTP REST request and return response body or raise the error
      #
      # @example
      #   Teamsupport::REST::Request.new(self, request_method, path, options).perform
      #
      # @return [Array, Hash]
      #
      # @api public
      def perform
        options_key = @request_method == :get ? :params : :body
        # For non-GET requests need to send the options as JSON in the request body
        response = http_client.headers(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
        response_body = response.body.empty? ? '' : symbolize_keys!(response.parse)
        response_headers = response.headers
        fail_or_return_response_body(response.code, response_body, response_headers)
      end

    private

      # Check response and raise an error or return the response body if successful
      #
      # @param code [Strin]
      # @param body [String]
      # @param headers [String]
      #
      # @raise [Teamsupport::Error] Error raised based on response code/body/headers
      #
      # @return [Array, Hash]
      #
      # @api private
      def fail_or_return_response_body(code, body, headers)
        error = error(code, body, headers)
        raise(error) if error
        body
      end

      # Check response code/body/headers for errors and return Teamsupport::Error
      #
      # @param code [Strin]
      # @param body [String]
      # @param headers [String]
      #
      # @return [Teamsupport::Error, nil]
      #
      # @api private
      def error(code, body, headers)
        klass = Teamsupport::Error::ERRORS[code]

        klass.from_response(body, headers) unless klass.nil?
      end

      # Convert array/hash keys to symbols
      #
      # @param object [Array, Hash]
      #
      # @return [Hash, Array]
      #
      # @api private
      def symbolize_keys!(object)
        if object.is_a?(Array)
          object.each_with_index do |val, index|
            object[index] = symbolize_keys!(val)
          end
        elsif object.is_a?(Hash)
          object.keys.each do |key|
            object[key.to_sym] = symbolize_keys!(object.delete(key))
          end
        end
        object
      end

      # Returns the HTTP Client object
      #
      # @return [HTTP::Client, HTTP]
      #
      # @api private
      def http_client
        HTTP
      end
    end
  end
end
