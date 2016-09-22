require 'helper'

describe Teamsupport::REST::Client do
  before do
    @client = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
  end

  describe '#auth?' do
    it 'returns true if all auth values are present' do
      client = Teamsupport::REST::Client.new(api_key: 'AK', api_secret: 'AS')
      expect(client.auth?).to be true
    end
    it 'returns false if any auth values are missing' do
      client = Teamsupport::REST::Client.new(api_key: 'AK')
      expect(client.auth?).to be false
    end
  end
end
