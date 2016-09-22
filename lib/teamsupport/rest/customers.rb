require 'teamsupport/error'
require 'teamsupport/customer'
require 'teamsupport/rest/utils'
require 'teamsupport/utils'

module Teamsupport
  module REST
    module Customers
      include Teamsupport::REST::Utils
      include Teamsupport::Utils

      # Returns all available customers for the TeamSupport organization
      #
      # @see http://help.teamsupport.com/1/en/topic/api
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.customers()
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied API credentials are not valid.
      #
      # @return [Array<Teamsupport::Customer>]
      #
      # @param options [Hash] A customizable set of options.
      #
      # @option options [Integer] :count Specifies the number of records to retrieve.
      #
      # @api public
      def customers(options = {})
        perform_get_with_objects_from_collection('/api/json/customers.json', options, Teamsupport::Customer, :Customers)
      end

      # Returns a customer
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.customer('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Customer] The requested customer.
      #
      # @param id [Integer] A customer ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def customer(id, options = {})
        perform_get_with_object_from_collection("/api/json/customers/#{id}.json", options, Teamsupport::Customer, :Customer)
      end

      # Create a customer
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.create_customer(Name: 'New Customer')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Customer] The new customer.
      #
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def create_customer(options = {})
        perform_post_with_object_from_collection('/api/json/customers.json', options, Teamsupport::Customer, :Customer)
      end

      # Updates the customer
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.update_customer('1', Name: 'Updated Customer Name')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Customer] The updated customer.
      #
      # @param id [Integer] A customer ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def update_customer(id, options = {})
        customer_hash = customer(id).to_h
        perform_put_with_object_from_collection("/api/json/customers/#{id}.json", customer_hash.merge(options), Teamsupport::Customer, :Customer)
      end

      # Deletes the customer
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.delete_customer('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @param id [Integer] A customer ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def delete_customer(id, options = {})
        perform_delete("/api/json/customers/#{id}.json", options)
      end

      # Returns the products for a customer
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.customer_products('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Array<Teamsupport::Product>]
      #
      # @param id [Integer] A customer ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def customer_products(id, options = {})
        options = options.dup
        perform_get_with_objects_from_collection("/api/json/customers/#{id}/products.json", options, Teamsupport::CustomerProduct, :OrganizationProducts)
      end

      # Returns the tickets for a customer
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.customer_tickets('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Array<Teamsupport::Ticket>]
      #
      # @param id [Integer] A customer ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def customer_tickets(id, options = {})
        options = options.dup
        perform_get_with_objects_from_collection("/api/json/customers/#{id}/tickets.json", options, Teamsupport::Ticket, :Tickets)
      end
    end
  end
end
