require 'teamsupport/base'
require 'teamsupport/creatable'
require 'teamsupport/identity'

module Teamsupport
  class Customer < Teamsupport::Identity
    include Teamsupport::Creatable

    # @return [Integer]
    attr_reader :ID, :PrimaryUserID, :CreatorID, :ModifierID, :SlaLevelID, :DefaultSupportGroupID, :DefaultSupportUserID, :SupportHoursMonth, :SupportHoursUsed, :SupportHoursRemaining
    # @return [String]
    attr_reader :Name, :Description, :Website, :InActiveReason, :PrimaryContact, :Domains, :CreatedBy, :LastModifiedBy, :SlaName, :CRMLinkId, :DefaultWikiArticle, :DefaultSupportGroup, :DefaultSupportUser

    # Boolean indicating whether a Customer is active on Teamsupport
    #
    # @example
    #   teamsupport_customer = Teamsupport::Customer.new(IsActive: true)
    #   teamsupport_customer.IsActive
    #
    # @return [Boolean]
    #
    # @api public
    def IsActive # rubocop:disable Style/MethodName
      @attrs[:IsActive] == 'True' ? true : false
    end

    # Boolean indicating whether a Customer has portal access on Teamsupport
    #
    # @example
    #   teamsupport_customer = Teamsupport::Customer.new(HasPortalAccess: true)
    #   teamsupport_customer.HasPortalAccess
    #
    # @return [Boolean]
    #
    # @api public
    def HasPortalAccess # rubocop:disable Style/MethodName
      @attrs[:HasPortalAccess] == 'True' ? true : false
    end

    # Boolean indicating whether a Customer needs indexing on Teamsupport
    #
    # @example
    #   teamsupport_customer = Teamsupport::Customer.new(NeedsIndexing: true)
    #   teamsupport_customer.NeedsIndexing
    #
    # @return [Boolean]
    #
    # @api public
    def NeedsIndexing # rubocop:disable Style/MethodName
      @attrs[:NeedsIndexing] == 'True' ? true : false
    end

    # Time when the Customer's Service Agreement expires on Teamsupport
    #
    # @example
    #   teamsupport_customer = Teamsupport::Customer.new(SAExpirationDate: '4/4/2015 10:15 AM')
    #   teamsupport_customer.SAExpirationDate
    #
    # @return [Time]
    #
    # @api public
    def SAExpirationDate # rubocop:disable Style/MethodName
      Time.strptime(@attrs[:SAExpirationDate], '%m/%d/%Y %l:%M %p').utc unless @attrs[:SAExpirationDate].nil?
    end
  end
end
