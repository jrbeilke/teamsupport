require 'helper'

describe Teamsupport::Identity do
  describe '#initialize' do
    it 'raises an IndexError when ID is not specified' do
      expect { Teamsupport::Identity.new }.to raise_error(IndexError)
    end
  end

  describe '#==' do
    it 'returns true when objects IDs are the same' do
      one = Teamsupport::Identity.new(ID: 1, Name: 'jrbeilke')
      two = Teamsupport::Identity.new(ID: 1, Name: 'jdoe')
      expect(one == two).to be true
    end
    it 'returns false when objects IDs are different' do
      one = Teamsupport::Identity.new(ID: 1)
      two = Teamsupport::Identity.new(ID: 2)
      expect(one == two).to be false
    end
    it 'returns false when classes are different' do
      one = Teamsupport::Identity.new(ID: 1)
      two = Teamsupport::Base.new(ID: 1)
      expect(one == two).to be false
    end
  end
end
