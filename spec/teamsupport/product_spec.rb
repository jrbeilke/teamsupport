# coding: utf-8
require 'helper'

describe Teamsupport::Product do
  before do
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  after do
    $stderr = @old_stderr
  end

  describe '#==' do
    it 'returns true when objects IDs are the same' do
      product = Teamsupport::Product.new(ID: '1', Name: 'foo')
      other = Teamsupport::Product.new(ID: '1', Name: 'bar')
      expect(product == other).to be true
    end
    it 'returns false when objects IDs are different' do
      product = Teamsupport::Product.new(ID: '1')
      other = Teamsupport::Product.new(ID: '2')
      expect(product == other).to be false
    end
    it 'returns false when classes are different' do
      product = Teamsupport::Product.new(ID: '1')
      other = Teamsupport::Ticket.new(ID: '1')
      expect(product == other).to be false
    end
  end

  describe '#dateCreated' do
    it 'returns a Time when dateCreated is set' do
      product = Teamsupport::Product.new(ID: '1234', DateCreated: '4/4/2015 9:45 AM')
      expect(product.DateCreated).to be_a Time
      expect(product.DateCreated).to be_utc
    end
    it 'returns nil when dateCreated is not set' do
      product = Teamsupport::Product.new(ID: '1234')
      expect(product.DateCreated).to be_nil
    end
  end

  describe '#dateModified' do
    it 'returns a Time when dateModified is set' do
      product = Teamsupport::Product.new(ID: '1234', DateModified: '4/4/2015 10:00 AM')
      expect(product.DateModified).to be_a Time
      expect(product.DateModified).to be_utc
    end
    it 'returns nil when dateModified is not set' do
      product = Teamsupport::Product.new(ID: '1234')
      expect(product.DateModified).to be_nil
    end
  end

  describe '#customFields' do
    it 'returns custom field value when one custom field name is provided' do
      product = Teamsupport::Product.new(ID: '1234', CustomField1: '1212')
      expect(product.attrs[:CustomField1]).to eq('1212')
    end
    it 'returns custom field values when multiple custom field names are provided' do
      product = Teamsupport::Product.new(ID: '1234', CustomField1: '1212', CustomField2: '2323')
      expect(product.attrs[:CustomField1]).to eq('1212')
      expect(product.attrs[:CustomField2]).to eq('2323')
    end
    it 'returns nil when custom field is not set' do
      product = Teamsupport::Product.new(ID: '1234')
      expect(product.attrs[:CustomField1]).to be_nil
    end
  end
end
