require 'helper'

describe Teamsupport::REST::Tickets do
  before do
    @client = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
  end

  describe '#ticket' do
    context 'when request ticket' do
      before do
        stub_get(@client.api_url, '/api/json/tickets/745895.json').to_return(body: fixture('ticket.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.ticket('745895')
        expect(a_get(@client.api_url, '/api/json/tickets/745895.json')).to have_been_made
      end
      it 'returns the specified ticket' do
        ticket = @client.ticket('745895')
        expect(ticket).to be_a Teamsupport::Ticket
        expect(ticket.ID).to eq('745895')
      end
      it 'returns value for custom field' do
        ticket = @client.ticket('745895')
        expect(ticket.attrs[:CustomField1]).to eq('1111')
      end
      it 'returns proper boolean for IsClosed' do
        ticket = @client.ticket('745895')
        expect(ticket.IsClosed).to eq(true)
      end
    end
    context 'when create_ticket' do
      before do
        stub_post(@client.api_url, '/api/json/tickets.json').to_return(body: fixture('create_ticket.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.create_ticket(Name: 'Test Ticket Create')
        expect(a_post(@client.api_url, '/api/json/tickets.json')).to have_been_made
      end
      it 'returns the specified ticket' do
        ticket = @client.create_ticket(Name: 'Test Ticket Create')
        expect(ticket).to be_a Teamsupport::Ticket
        expect(ticket.ID).to eq('745895')
        expect(ticket.Name).to eq('Test Ticket Create')
      end
      it 'returns value for custom field' do
        ticket = @client.create_ticket(Name: 'Test Ticket Create')
        expect(ticket.attrs[:CustomField1]).to eq('1111')
      end
      it 'returns proper boolean for IsClosed' do
        ticket = @client.create_ticket(Name: 'Test Ticket Create')
        expect(ticket.IsClosed).to eq(true)
      end
    end
    context 'when update_ticket' do
      before do
        stub_get(@client.api_url, '/api/json/tickets/745895.json').to_return(body: fixture('ticket.json'), headers: {content_type: 'application/json; charset=utf-8'})
        stub_put(@client.api_url, '/api/json/tickets/745895.json').to_return(body: fixture('update_ticket.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resources' do
        @client.update_ticket('745895', Name: 'Test Ticket Update')
        expect(a_get(@client.api_url, '/api/json/tickets/745895.json')).to have_been_made
        expect(a_put(@client.api_url, '/api/json/tickets/745895.json')).to have_been_made
      end
      it 'returns the updated ticket' do
        ticket = @client.update_ticket('745895', Name: 'Test Ticket Update')
        expect(ticket).to be_a Teamsupport::Ticket
        expect(ticket.ID).to eq('745895')
        expect(ticket.Name).to eq('Test Ticket Update')
      end
      it 'returns value for custom field' do
        ticket = @client.update_ticket('745895', Name: 'Test Ticket Update')
        expect(ticket.attrs[:CustomField1]).to eq('1111')
      end
      it 'returns proper boolean for IsClosed' do
        ticket = @client.update_ticket('745895', Name: 'Test Ticket Update')
        expect(ticket.IsClosed).to eq(true)
      end
    end
    context 'when delete_ticket' do
      before do
        stub_delete(@client.api_url, '/api/json/tickets/745895.json').to_return(body: fixture('ticket.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.delete_ticket('745895')
        expect(a_delete(@client.api_url, '/api/json/tickets/745895.json')).to have_been_made
      end
    end
  end

  describe '#tickets' do
    # TODO: test for multiple ids passed
    context 'without ids passed' do
      before do
        stub_get(@client.api_url, '/api/json/tickets.json').to_return(body: fixture('tickets.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.tickets
        expect(a_get(@client.api_url, '/api/json/tickets.json')).to have_been_made
      end
      it 'returns an array of tickets' do
        tickets = @client.tickets
        expect(tickets).to be_an Array
        expect(tickets.first).to be_a Teamsupport::Ticket
        expect(tickets.first.ID).to eq('745895')
      end
      it 'returns value for custom field' do
        tickets = @client.tickets
        expect(tickets.first.attrs[:CustomField1]).to eq('1111')
      end
      it 'returns proper booleans for IsClosed' do
        tickets = @client.tickets
        expect(tickets[0].IsClosed).to eq(true)
        expect(tickets[1].IsClosed).to eq(false)
      end
    end
  end

  describe '#ticket_actions' do
    before do
      stub_get(@client.api_url, '/api/json/tickets/745895/actions.json').to_return(body: fixture('ticket_actions.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource' do
      @client.ticket_actions('745895')
      expect(a_get(@client.api_url, '/api/json/tickets/745895/actions.json')).to have_been_made
    end
    it 'returns an array of actions' do
      ticket_actions = @client.ticket_actions('745895')
      expect(ticket_actions).to be_an Array
      expect(ticket_actions.first).to be_a Teamsupport::TicketAction
      expect(ticket_actions.first.TicketID).to eq('745895')
    end
  end
end
