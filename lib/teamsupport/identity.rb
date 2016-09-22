require 'equalizer'
require 'teamsupport/base'

module Teamsupport
  class Identity < Teamsupport::Base
    include Equalizer.new(:ID)
    # @return [Integer]

    # Method for reading the TeamSupport ID of an object
    #
    # @example
    #   teamsupport_object = Teamsupport::Identity.new(ID: 1)
    #   teamsupport_object.ID
    #
    # @return [Integer]
    #
    # @api public
    attr_reader :ID

    # Initializes a new object
    #
    # @param attrs [Hash]
    #
    # @raise [ArgumentError] Error raised when supplied argument is missing an :ID key.
    #
    # @return [Teamsupport::Identity]
    #
    # @api private
    def initialize(attrs = {})
      # Workaround for dealing with TeamSupport API inconsistently sending ID for objects
      unless attrs[:ID]
        attrs[:ID] = attrs.fetch(:OrganizationID) if attrs[:OrganizationID]

        attrs[:ID] = attrs.fetch(:ProductID) if attrs[:ProductID]

        attrs[:ID] = attrs.fetch(:TicketID) if attrs[:TicketID]
      end

      attrs.fetch(:ID)
      super
    end
  end
end
