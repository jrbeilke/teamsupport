require 'teamsupport/base'
require 'teamsupport/creatable'
require 'teamsupport/identity'

module Teamsupport
  class Product < Teamsupport::Identity
    include Teamsupport::Creatable

    # @return [Integer]
    attr_reader :ID, :CreatorID, :ModifierID
    # @return [String]
    attr_reader :Name, :Description
  end
end
