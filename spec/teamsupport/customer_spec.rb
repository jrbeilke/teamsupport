# coding: utf-8
require 'helper'

describe Teamsupport::Customer do
  before do
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  after do
    $stderr = @old_stderr
  end

  describe '#==' do
    it 'returns true when objects IDs are the same' do
      customer = Teamsupport::Customer.new(ID: '1', Name: 'foo')
      other = Teamsupport::Customer.new(ID: '1', Name: 'bar')
      expect(customer == other).to be true
    end
    it 'returns false when objects IDs are different' do
      customer = Teamsupport::Customer.new(ID: '1')
      other = Teamsupport::Customer.new(ID: '2')
      expect(customer == other).to be false
    end
    it 'returns false when classes are different' do
      customer = Teamsupport::Customer.new(ID: '1')
      other = Teamsupport::Product.new(ID: '1')
      expect(customer == other).to be false
    end
  end

  describe '#DateCreated' do
    it 'returns a Time when DateCreated is set' do
      customer = Teamsupport::Customer.new(ID: '1234', DateCreated: '4/4/2015 9:45 AM')
      expect(customer.DateCreated).to be_a Time
      expect(customer.DateCreated).to be_utc
    end
    it 'returns nil when dateCreated is not set' do
      customer = Teamsupport::Customer.new(ID: '1234')
      expect(customer.DateCreated).to be_nil
    end
  end

  describe '#DateModified' do
    it 'returns a Time when DateModified is set' do
      customer = Teamsupport::Customer.new(ID: '1234', DateModified: '4/4/2015 10:00 AM')
      expect(customer.DateModified).to be_a Time
      expect(customer.DateModified).to be_utc
    end
    it 'returns nil when dateModified is not set' do
      customer = Teamsupport::Customer.new(ID: '1234')
      expect(customer.DateModified).to be_nil
    end
  end

  describe '#IsActive' do
    it 'returns a true boolean when IsActive is "True" string' do
      customer = Teamsupport::Customer.new(ID: '1234', IsActive: 'True')
      expect(customer.IsActive).to eql(true)
    end
    it 'returns false boolean when IsActive is "False" string' do
      customer = Teamsupport::Customer.new(ID: '1234', IsActive: 'False')
      expect(customer.IsActive).to eql(false)
    end
    it 'returns false boolean when IsActive is not set' do
      customer = Teamsupport::Customer.new(ID: '1234')
      expect(customer.IsActive).to eql(false)
    end
  end

  describe '#HasPortalAccess' do
    it 'returns a true boolean when HasPortalAccess is "True" string' do
      customer = Teamsupport::Customer.new(ID: '1234', HasPortalAccess: 'True')
      expect(customer.HasPortalAccess).to eql(true)
    end
    it 'returns false boolean when HasPortalAccess is "False" string' do
      customer = Teamsupport::Customer.new(ID: '1234', HasPortalAccess: 'False')
      expect(customer.HasPortalAccess).to eql(false)
    end
    it 'returns false boolean when HasPortalAccess is not set' do
      customer = Teamsupport::Customer.new(ID: '1234')
      expect(customer.HasPortalAccess).to eql(false)
    end
  end

  describe '#NeedsIndexing' do
    it 'returns a true boolean when NeedsIndexing is "True" string' do
      customer = Teamsupport::Customer.new(ID: '1234', NeedsIndexing: 'True')
      expect(customer.NeedsIndexing).to eql(true)
    end
    it 'returns false boolean when NeedsIndexing is "False" string' do
      customer = Teamsupport::Customer.new(ID: '1234', NeedsIndexing: 'False')
      expect(customer.NeedsIndexing).to eql(false)
    end
    it 'returns false boolean when NeedsIndexing is not set' do
      customer = Teamsupport::Customer.new(ID: '1234')
      expect(customer.NeedsIndexing).to eql(false)
    end
  end

  describe '#SAExpirationDate' do
    it 'returns a Time when SAExpirationDate is set' do
      customer = Teamsupport::Customer.new(ID: '1234', SAExpirationDate: '4/4/2015 10:15 AM')
      expect(customer.SAExpirationDate).to be_a Time
      expect(customer.SAExpirationDate).to be_utc
    end
    it 'returns nil when SAExpirationDate is not set' do
      customer = Teamsupport::Customer.new(ID: '1234')
      expect(customer.SAExpirationDate).to be_nil
    end
  end

  describe '#customFields' do
    it 'returns custom field value when one custom field name is provided' do
      customer = Teamsupport::Customer.new(ID: '1234', CustomField1: '11')
      expect(customer.attrs[:CustomField1]).to eq('11')
    end
    it 'returns custom field values when multiple custom field names are provided' do
      customer = Teamsupport::Customer.new(ID: '1234', CustomField1: '11', CustomField2: '22')
      expect(customer.attrs[:CustomField1]).to eq('11')
      expect(customer.attrs[:CustomField2]).to eq('22')
    end
    it 'returns nil when custom field is not set' do
      customer = Teamsupport::Customer.new(ID: '1234')
      expect(customer.attrs[:CustomField1]).to be_nil
    end
  end
end
