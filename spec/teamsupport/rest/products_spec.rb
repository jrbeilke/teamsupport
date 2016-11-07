require 'helper'

describe Teamsupport::REST::Products do
  before do
    @client = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
  end

  describe '#product' do
    context 'when request product' do
      before do
        stub_get(@client.api_url, '/api/json/products/2353.json').to_return(body: fixture('product.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.product('2353')
        expect(a_get(@client.api_url, '/api/json/products/2353.json')).to have_been_made
      end
      it 'returns the specified product' do
        product = @client.product('2353')
        expect(product).to be_a Teamsupport::Product
        expect(product.ID).to eq('2353')
      end
      it 'returns value for custom field' do
        product = @client.product('2353')
        expect(product.attrs[:CustomField1]).to eq('1212')
      end
    end
    context 'when create_product' do
      before do
        stub_post(@client.api_url, '/api/json/products.json').to_return(body: fixture('create_product.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.create_product(Name: 'Test Product Create')
        expect(a_post(@client.api_url, '/api/json/products.json')).to have_been_made
      end
      it 'returns the specified product' do
        product = @client.create_product(Name: 'Test Product Create')
        expect(product).to be_a Teamsupport::Product
        expect(product.ID).to eq('2353')
        expect(product.Name).to eq('Test Product Create')
      end
      it 'returns value for custom field' do
        product = @client.create_product(Name: 'Test Product Create')
        expect(product.attrs[:CustomField1]).to eq('1212')
      end
    end
    context 'when update_product' do
      before do
        stub_get(@client.api_url, '/api/json/products/2353.json').to_return(body: fixture('product.json'), headers: {content_type: 'application/json; charset=utf-8'})
        stub_put(@client.api_url, '/api/json/products/2353.json').to_return(body: fixture('update_product.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resources' do
        @client.update_product('2353', Name: 'Test Product Update')
        expect(a_get(@client.api_url, '/api/json/products/2353.json')).to have_been_made
        expect(a_put(@client.api_url, '/api/json/products/2353.json')).to have_been_made
      end
      it 'returns the updated customer' do
        product = @client.update_product('2353', Name: 'Test Product Update')
        expect(product).to be_a Teamsupport::Product
        expect(product.ID).to eq('2353')
        expect(product.Name).to eq('Test Product Update')
      end
      it 'returns value for custom field' do
        product = @client.update_product('2353', Name: 'Test Product Update')
        expect(product.attrs[:CustomField1]).to eq('1212')
      end
    end
    context 'when delete_product' do
      before do
        stub_delete(@client.api_url, '/api/json/products/2353.json').to_return(body: fixture('product.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.delete_product('2353')
        expect(a_delete(@client.api_url, '/api/json/products/2353.json')).to have_been_made
      end
    end
  end

  describe '#products' do
    # TODO: test for multiple ids passed
    context 'without ids passed' do
      before do
        stub_get(@client.api_url, '/api/json/products.json').to_return(body: fixture('products.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'requests the correct resource' do
        @client.products
        expect(a_get(@client.api_url, '/api/json/products.json')).to have_been_made
      end
      it 'returns an array of products' do
        products = @client.products
        expect(products).to be_an Array
        expect(products.first).to be_a Teamsupport::Product
        expect(products.first.ID).to eq('2353')
      end
      it 'returns value for custom field' do
        products = @client.products
        expect(products.first.attrs[:CustomField1]).to eq('1212')
      end
    end
  end
end
