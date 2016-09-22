require 'time'

module Teamsupport
  module Creatable
    # Time when object was created on TeamSupport
    #
    # @example
    #   teamsupport_object = Teamsupport::Creatable.new(DateCreated: '4/4/2015 9:45 AM')
    #   teamsupport_object.DateCreated
    #
    # @return [Time]
    #
    # @api public
    def DateCreated # rubocop:disable Style/MethodName
      Time.strptime(@attrs[:DateCreated], '%m/%d/%Y %l:%M %p').utc unless @attrs[:DateCreated].nil?
    end

    # Time when object was last modified on TeamSupport
    #
    # @example
    #   teamsupport_object = Teamsupport::Creatable.new(DateModified: '4/4/2015 10:00 AM')
    #   teamsupport_object.DateModified
    #
    # @return [Time]
    #
    # @api public
    def DateModified # rubocop:disable Style/MethodName
      Time.strptime(@attrs[:DateModified], '%m/%d/%Y %l:%M %p').utc unless @attrs[:DateModified].nil?
    end
  end
end
