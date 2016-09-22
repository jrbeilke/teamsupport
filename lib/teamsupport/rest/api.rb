require 'teamsupport/rest/customers'
require 'teamsupport/rest/products'
require 'teamsupport/rest/tickets'

module Teamsupport
  module REST
    module API
      # TODO: include Teamsupport::REST::Assets
      # TODO: include Teamsupport::REST::Contacts
      include Teamsupport::REST::Customers
      # TODO: include Teamsupport::REST::Groups
      include Teamsupport::REST::Products
      # TODO: include Teamsupport::REST::Properties
      include Teamsupport::REST::Tickets
      # TODO: include Teamsupport::REST::Users
      # TODO: include Teamsupport::REST::Wiki
    end
  end
end
