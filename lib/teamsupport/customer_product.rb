require 'teamsupport/base'
require 'teamsupport/creatable'
require 'teamsupport/product'

module Teamsupport
  class CustomerProduct < Teamsupport::Product
    include Teamsupport::Creatable

    # @return [Integer]
    attr_reader :ID, :CreatorID, :ModifierID, :OrganizationID, :ProductID
    # @return [String]
    attr_reader :Name, :Description
  end
end
