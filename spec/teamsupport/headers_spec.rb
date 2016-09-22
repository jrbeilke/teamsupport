require 'helper'

describe Teamsupport::Headers do
  before do
    @client = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
    @headers = Teamsupport::Headers.new(@client, :get, Teamsupport::REST::Request::BASE_URL + '/path')
  end

  describe '#auth_header' do
    it 'creates the correct auth header with supplied api_key and api_secret' do
      authorization = @headers.send(:auth_header)
      expect(authorization).to eq('Basic QUs6QVM=')
    end
  end
end
