require 'teamsupport/error'
require 'teamsupport/utils'
require 'teamsupport/version'

module Teamsupport
  class Client
    # Provide api_key and api_secret methods for accessing Client API values
    #
    # @example
    #   teamsupport_client = Teamsupport::Client.new(api_key: 'AK', api_secret: 'AS')
    #   teamsupport_client.api_key
    #   teamsupport_client.api_secret
    #
    # @return [String]
    #
    # @api public
    attr_accessor :api_key, :api_secret

    # Provide user_agent method for overriding default Client user_agent value
    #
    # @example
    #   teamsupport_client = Teamsupport::Client.new(api_key: 'AK', api_secret: 'AS')
    #   teamsupport_client.user_agent = 'MyTeamsupportClient/1.0.0'
    #
    # @return [String]
    #
    # @api public
    attr_writer :user_agent

    # Initializes a new Client object
    #
    # @param options [Hash]
    #
    # @return [Teamsupport::Client]
    #
    # @api private
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    # Returns user agent string for the Client
    #
    # @example
    #   teamsupport_client = Teamsupport::Client.new(api_key: 'AK', api_secret: 'AS')
    #   teamsupport_client.user_agent
    #
    # @return [String]
    #
    # @api public
    def user_agent
      @user_agent ||= "TeamsupportRubyGem/#{Teamsupport::Version}"
    end

    # Returns authentication hash for the Client
    #
    # @example
    #   teamsupport_client = Teamsupport::Client.new(api_key: 'AK', api_secret: 'AS')
    #   teamsupport_client.auth
    #
    # @return [Hash]
    #
    # @api public
    def auth
      {
        user: api_key,
        password: api_secret,
      }
    end

    # Checks for the existence of an authentication hash on the Client
    #
    # @example
    #   teamsupport_client = Teamsupport::Client.new(api_key: 'AK', api_secret: 'AS')
    #   teamsupport_client.auth?
    #
    # @return [Boolean]
    #
    # @api public
    def auth?
      auth.values.all?
    end
  end
end
