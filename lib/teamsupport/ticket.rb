require 'teamsupport/base'
require 'teamsupport/creatable'
require 'teamsupport/identity'

module Teamsupport
  class Ticket < Teamsupport::Identity
    include Teamsupport::Creatable

    # @return [Integer]
    attr_reader :ID, :StatusPosition, :SeverityPosition, :TicketNumber, :ReportedVersionID, :SolvedVersionID, :ProductID, :GroupID, :UserID, :TicketStatusID, :TicketTypeID, :TicketSeverityID, :OrganizationID, :ParentID, :ModifierID, :CreatorID, :CloserID, :DaysClosed, :DaysOpened, :KnowledgeBaseCategoryID
    # @return [Float]
    attr_reader :HoursSpent, :SlaViolationTime, :SlaWarningTime, :SlaViolationHours, :SlaWarningHours
    # @return [String]
    attr_reader :ProductName, :ReportedVersion, :SolvedVersion, :GroupName, :TicketTypeName, :UserName, :Status, :Severity, :Name, :CloserName, :CreatorName, :ModifierName, :KnowledgeBaseCategoryName, :TicketSource

    # Boolean indicating whether a Ticket is closed on Teamsupport
    #
    # @example
    #   teamsupport_ticket = Teamsupport::Ticket.new(IsClosed: true)
    #   teamsupport_ticket.IsClosed
    #
    # @return [Boolean]
    #
    # @api public
    def IsClosed # rubocop:disable Style/MethodName
      @attrs[:IsClosed] == 'True' ? true : false
    end

    # Boolean indicating whether a Ticket is visible via the portal on Teamsupport
    #
    # @example
    #   teamsupport_ticket = Teamsupport::Ticket.new(IsVisibleOnPortal: true)
    #   teamsupport_ticket.IsVisibleOnPortal
    #
    # @return [Boolean]
    #
    # @api public
    def IsVisibleOnPortal # rubocop:disable Style/MethodName
      @attrs[:IsVisibleOnPortal] == 'True' ? true : false
    end

    # Boolean indicating whether a Ticket is shown in the knowledgebase on Teamsupport
    #
    # @example
    #   teamsupport_ticket = Teamsupport::Ticket.new(IsKnowledgeBase: true)
    #   teamsupport_ticket.IsKnowledgeBase
    #
    # @return [Boolean]
    #
    # @api public
    def IsKnowledgeBase # rubocop:disable Style/MethodName
      @attrs[:IsKnowledgeBase] == 'True' ? true : false
    end

    # Time when the Ticket was closed on Teamsupport
    #
    # @example
    #   teamsupport_ticket = Teamsupport::Ticket.new(DateClosed: '4/4/2015 10:00 AM')
    #   teamsupport_ticket.DateClosed
    #
    # @return [Time]
    #
    # @api public
    def DateClosed # rubocop:disable Style/MethodName
      Time.strptime(@attrs[:DateClosed], '%m/%d/%Y %l:%M %p').utc unless @attrs[:DateClosed].nil?
    end

    # Time when the Ticket is due to be completed on Teamsupport
    #
    # @example
    #   teamsupport_ticket = Teamsupport::Ticket.new(DueDate: '4/4/2015 10:15 AM')
    #   teamsupport_ticket.DueDate
    #
    # @return [Time]
    #
    # @api public
    def DueDate # rubocop:disable Style/MethodName
      Time.strptime(@attrs[:DueDate], '%m/%d/%Y %l:%M %p').utc unless @attrs[:DueDate].nil?
    end
  end
end
