require 'teamsupport/error'
require 'teamsupport/product'
require 'teamsupport/rest/utils'
require 'teamsupport/utils'

module Teamsupport
  module REST
    module Products
      include Teamsupport::REST::Utils
      include Teamsupport::Utils

      # Returns all available products for the TeamSupport organization
      #
      # @see http://help.teamsupport.com/1/en/topic/api
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.products()
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied API credentials are not valid.
      #
      # @return [Array<Teamsupport::Product>]
      #
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] :count Specifies the number of records to retrieve.
      #
      # @api public
      def products(options = {})
        perform_get_with_objects_from_collection('/api/json/products.json', options, Teamsupport::Product, :Products)
      end

      # Returns a product
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.product('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Product] The requested product.
      #
      # @param id [Integer] A product ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def product(id, options = {})
        perform_get_with_object_from_collection("/api/json/products/#{id}.json", options, Teamsupport::Product, :Product)
      end

      # Create a product
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.create_product(Name: 'New Product')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Product] The new product.
      #
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def create_product(options = {})
        perform_post_with_object_from_collection('/api/json/products.json', options, Teamsupport::Product, :Product)
      end

      # Updates the product
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.update_product('1', Name: 'Updated Product Name')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @return [Teamsupport::Product] The updated product.
      #
      # @param id [Integer] A product ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def update_product(id, options = {})
        product_hash = product(id).to_h
        perform_put_with_object_from_collection("/api/json/products/#{id}.json", product_hash.merge(options), Teamsupport::Product, :Product)
      end

      # Deletes the product
      #
      # @example
      #   teamsupport_api = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      #   teamsupport_api.delete_product('1')
      #
      # @authentication Requires Basic Authentication
      #
      # @raise [Teamsupport::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      #
      # @param id [Integer] A product ID.
      # @param options [Hash] A customizable set of options.
      #
      # @api public
      def delete_product(id, options = {})
        perform_delete("/api/json/products/#{id}.json", options)
      end
    end
  end
end
