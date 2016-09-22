require 'helper'

describe Teamsupport::Client do
  describe '#user_agent' do
    it 'defaults TeamsupportRubyGem/version' do
      expect(subject.user_agent).to eq("TeamsupportRubyGem/#{Teamsupport::Version}")
    end
  end

  describe '#user_agent=' do
    it 'overwrites the User-Agent string' do
      subject.user_agent = 'MyTeamsupportClient/1.0.0'
      expect(subject.user_agent).to eq('MyTeamsupportClient/1.0.0')
    end
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
