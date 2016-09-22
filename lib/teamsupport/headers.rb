require 'addressable/uri'
require 'base64'

module Teamsupport
  class Headers
    # Initializes a new Headers object
    #
    # @param client [Teamsupport::Client]
    # @param request_method [String]
    # @param url [String]
    # @param options [Hash]
    #
    # @return [Teamsupport::Headers]
    #
    # @api private
    def initialize(client, request_method, url, options = {})
      @client = client
      @request_method = request_method.to_sym
      @uri = Addressable::URI.parse(url)
      @options = options
    end

    # Returns HTTP request headers for the client
    #
    # @example
    #   teamsupport_client = Teamsupport::Client.new(api_key: 'AK', api_secret: 'AS')
    #   teamsupport_headers = Teamsupport::Headers.new(teamsupport_client, :get, 'https://app.teamsupport.com')
    #   teamsupport_headers.request_headers
    #
    # @return [Hash]
    #
    # @api public
    def request_headers
      headers = {'Content-Type' => 'application/json'}
      headers[:user_agent] = @client.user_agent
      headers[:authorization] = auth_header
      headers
    end

  private

    # Generates authentication header for TeamSupport API's basic auth
    #
    # @return [String]
    #
    # @api private
    def auth_header
      "Basic #{Base64.strict_encode64("#{@client.api_key}:#{@client.api_secret}")}"
    end
  end
end
