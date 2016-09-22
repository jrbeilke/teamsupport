require 'helper'

describe Teamsupport::Version do
  before do
    allow(Teamsupport::Version).to receive(:major).and_return(1)
    allow(Teamsupport::Version).to receive(:minor).and_return(2)
    allow(Teamsupport::Version).to receive(:patch).and_return(3)
    allow(Teamsupport::Version).to receive(:pre).and_return(nil)
  end

  describe '.to_h' do
    it 'returns a hash with the right values' do
      expect(Teamsupport::Version.to_h).to be_a Hash
      expect(Teamsupport::Version.to_h[:major]).to eq(1)
      expect(Teamsupport::Version.to_h[:minor]).to eq(2)
      expect(Teamsupport::Version.to_h[:patch]).to eq(3)
      expect(Teamsupport::Version.to_h[:pre]).to eq(nil)
    end
  end

  describe '.to_a' do
    it 'returns an array with the right values' do
      expect(Teamsupport::Version.to_a).to be_an Array
      expect(Teamsupport::Version.to_a).to eq([1, 2, 3])
    end
  end

  describe '.to_s' do
    it 'returns a string with the right value' do
      expect(Teamsupport::Version.to_s).to be_a String
      expect(Teamsupport::Version.to_s).to eq('1.2.3')
    end
  end
end
