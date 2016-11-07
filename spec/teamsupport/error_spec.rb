require 'helper'

describe Teamsupport::Error do
  before do
    @client = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
  end

  describe '#code' do
    it 'returns the error code' do
      error = Teamsupport::Error.new('execution expired', 123)
      expect(error.code).to eq(123)
    end
  end

  describe '#message' do
    it 'returns the error message' do
      error = Teamsupport::Error.new('execution expired')
      expect(error.message).to eq('execution expired')
    end
  end

  %w(error errors).each do |key|
    context "when JSON body contains #{key}" do
      before do
        body = "{\"#{key}\":\"Internal Server Error\"}"
        stub_get(@client.api_url, '/api/json/customers/x500.json').to_return(status: 500, body: body, headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'raises an exception with the proper message' do
        expect { @client.customer('x500') }.to raise_error(Teamsupport::Error::InternalServerError)
      end
    end
  end

  Teamsupport::Error::ERRORS.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        stub_get(@client.api_url, '/api/json/customers/x.json').to_return(status: status, body: '{}', headers: {content_type: 'application/json; charset=utf-8'})
      end
      it "raises #{exception}" do
        expect { @client.customer('x') }.to raise_error(exception)
      end
    end
  end
end
