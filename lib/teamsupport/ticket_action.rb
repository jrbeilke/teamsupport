require 'teamsupport/base'
require 'teamsupport/creatable'
require 'teamsupport/ticket'

module Teamsupport
  class TicketAction < Teamsupport::Ticket
    include Teamsupport::Creatable

    # @return [Integer]
    attr_reader :ID, :CreatorID, :ModifierID, :UserID, :OrganizationID, :ProductID, :TicketID, :TicketNumber
    # @return [Float]
    attr_reader :HoursSpent, :SlaViolationTime, :SlaWarningTime, :SlaViolationHours, :SlaWarningHours
    # @return [String]
    attr_reader :Name, :Description, :ActionType, :CreatorName, :ModifierName, :UserName
  end
end
