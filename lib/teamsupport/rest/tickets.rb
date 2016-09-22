require 'teamsupport/error'
require 'teamsupport/ticket'
require 'teamsupport/rest/utils'
require 'teamsupport/utils'

module Teamsupport
  module REST
    module Tickets
      include Teamsupport::REST::Utils
      include Teamsupport::Utils

      # Returns all available tickets for the TeamSupport organization
      #
      # @see http://help.teamsupport.com/1/en/topic/api
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.tickets()
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied API credentials are not valid.
      #
      # @return [Array<Teamsupport::Ticket>]
      #
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] :count Specifies the number of records to retrieve.
      #
      # @api public
      def tickets(options = {})
        perform_get_with_objects_from_collection('/api/json/tickets.json', options, Teamsupport::Ticket, :Tickets)
      end

      # Returns a customer
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.ticket('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Ticket] The requested ticket.
      #
      # @param id [Integer] A ticket ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def ticket(id, options = {})
        perform_get_with_object_from_collection("/api/json/tickets/#{id}.json", options, Teamsupport::Ticket, :Ticket)
      end

      # Create a ticket
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.create_ticket(Name: 'New Ticket', Description: 'Ticket Description')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Ticket] The new ticket.
      #
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def create_ticket(options = {})
        perform_post_with_object_from_collection('/api/json/tickets.json', options, Teamsupport::Ticket, :Ticket)
      end

      # Updates the ticket
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.update_ticket('1', Name: 'Updated Ticket Name')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Ticket] The updated ticket.
      #
      # @param id [Integer] A ticket ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def update_ticket(id, options = {})
        ticket_hash = ticket(id).to_h
        perform_put_with_object_from_collection("/api/json/tickets/#{id}.json", ticket_hash.merge(options), Teamsupport::Ticket, :Ticket)
      end

      # Deletes the ticket
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.delete_ticket('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @param id [Integer] A ticket ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def delete_ticket(id, options = {})
        perform_delete("/api/json/tickets/#{id}.json", options)
      end

      # Returns the actions for a ticket
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.ticket_actions('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Array<Teamsupport::Product>]
      #
      # @param id [Integer] A ticket ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def ticket_actions(id, options = {})
        options = options.dup
        perform_get_with_objects_from_collection("/api/json/tickets/#{id}/actions.json", options, Teamsupport::TicketAction, :Actions)
      end
    end
  end
end
