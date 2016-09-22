require 'helper'

describe Teamsupport::REST::Customers do
  before do
    @client = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
  end

  describe '#customer' do
    context 'when request customer' do
      before do
        stub_get('/api/json/customers/354788.json').to_return(body: fixture('customer.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.customer('354788')
        expect(a_get('/api/json/customers/354788.json')).to have_been_made
      end
      it 'returns the specified customer' do
        customer = @client.customer('354788')
        expect(customer).to be_a Teamsupport::Customer
        expect(customer.ID).to eq('354788')
      end
      it 'returns value for custom field' do
        customer = @client.customer('354788')
        expect(customer.attrs[:CustomField1]).to eq('11')
      end
      it 'returns proper boolean for IsActive' do
        customer = @client.customer('354788')
        expect(customer.IsActive).to eq(true)
      end
    end
    context 'when create_customer' do
      before do
        stub_post('/api/json/customers.json').to_return(body: fixture('create_customer.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.create_customer(Name: 'Test Customer Create')
        expect(a_post('/api/json/customers.json')).to have_been_made
      end
      it 'returns the specified customer' do
        customer = @client.create_customer(Name: 'Test Customer Create')
        expect(customer).to be_a Teamsupport::Customer
        expect(customer.ID).to eq('354788')
        expect(customer.Name).to eq('Test Customer Create')
      end
      it 'returns value for custom field' do
        customer = @client.create_customer(Name: 'Test Customer Create')
        expect(customer.attrs[:CustomField1]).to eq('11')
      end
      it 'returns proper boolean for IsActive' do
        customer = @client.create_customer(Name: 'Test Customer Create')
        expect(customer.IsActive).to eq(true)
      end
    end
    context 'when update_customer' do
      before do
        stub_get('/api/json/customers/354788.json').to_return(body: fixture('customer.json'), headers: {content_type: 'application/json; charset=utf-8'})
        stub_put('/api/json/customers/354788.json').to_return(body: fixture('update_customer.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resources' do
        @client.update_customer('354788', Name: 'Test Customer Update')
        expect(a_get('/api/json/customers/354788.json')).to have_been_made
        expect(a_put('/api/json/customers/354788.json')).to have_been_made
      end
      it 'returns the updated customer' do
        customer = @client.update_customer('354788', Name: 'Test Customer Update')
        expect(customer).to be_a Teamsupport::Customer
        expect(customer.ID).to eq('354788')
        expect(customer.Name).to eq('Test Customer Update')
      end
      it 'returns value for custom field' do
        customer = @client.update_customer('354788', Name: 'Test Customer Update')
        expect(customer.attrs[:CustomField1]).to eq('11')
      end
      it 'returns proper boolean for IsActive' do
        customer = @client.update_customer('354788', Name: 'Test Customer Update')
        expect(customer.IsActive).to eq(true)
      end
    end
    context 'when delete_customer' do
      before do
        stub_delete('/api/json/customers/354788.json').to_return(body: fixture('customer.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.delete_customer('354788')
        expect(a_delete('/api/json/customers/354788.json')).to have_been_made
      end
    end
  end

  describe '#customers' do
    # TODO: test for multiple ids passed
    context 'without ids passed' do
      before do
        stub_get('/api/json/customers.json').to_return(body: fixture('customers.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.customers
        expect(a_get('/api/json/customers.json')).to have_been_made
      end
      it 'returns an array of customers' do
        customers = @client.customers
        expect(customers).to be_an Array
        expect(customers.first).to be_a Teamsupport::Customer
        expect(customers.first.ID).to eq('354788')
      end
      it 'returns value for custom field' do
        customers = @client.customers
        expect(customers.first.attrs[:CustomField1]).to eq('11')
      end
      it 'returns proper booleans for IsActive' do
        customers = @client.customers
        expect(customers[0].IsActive).to eq(true)
        expect(customers[1].IsActive).to eq(false)
      end
    end
  end

  describe '#customer_products' do
    before do
      stub_get('/api/json/customers/354788/products.json').to_return(body: fixture('customer_products.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource' do
      @client.customer_products('354788')
      expect(a_get('/api/json/customers/354788/products.json')).to have_been_made
    end
    it 'returns an array of products' do
      customer_products = @client.customer_products('354788')
      expect(customer_products).to be_an Array
      expect(customer_products.first).to be_a Teamsupport::CustomerProduct
      expect(customer_products.first.OrganizationID).to eq('354788')
    end
  end

  describe '#customer_tickets' do
    before do
      stub_get('/api/json/customers/354788/tickets.json').to_return(body: fixture('customer_tickets.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource' do
      @client.customer_tickets('354788')
      expect(a_get('/api/json/customers/354788/tickets.json')).to have_been_made
    end
    it 'returns an array of tickets' do
      customer_tickets = @client.customer_tickets('354788')
      expect(customer_tickets).to be_an Array
      expect(customer_tickets.first).to be_a Teamsupport::Ticket
      expect(customer_tickets.first.OrganizationID).to eq('354788')
    end
  end
end
