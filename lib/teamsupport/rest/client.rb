require 'teamsupport/client'
require 'teamsupport/rest/api'
require 'teamsupport/rest/request'
require 'teamsupport/rest/utils'

module Teamsupport
  module REST
    class Client < Teamsupport::Client
      include Teamsupport::REST::API

      # Checks for the existence of an authentication hash on the Client
      #
      # @example
      #   teamsupport_client = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_client.auth?
      #
      # @return [Boolean]
      #
      # @api public
      def auth?
        super
      end
    end
  end
end
