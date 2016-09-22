# coding: utf-8
require 'helper'

describe Teamsupport::Ticket do
  before do
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  after do
    $stderr = @old_stderr
  end

  describe '#==' do
    it 'returns true when objects IDs are the same' do
      ticket = Teamsupport::Ticket.new(ID: '1', Name: 'foo')
      other = Teamsupport::Ticket.new(ID: '1', Name: 'bar')
      expect(ticket == other).to be true
    end
    it 'returns false when objects IDs are different' do
      ticket = Teamsupport::Ticket.new(ID: '1')
      other = Teamsupport::Ticket.new(ID: '2')
      expect(ticket == other).to be false
    end
    it 'returns false when classes are different' do
      ticket = Teamsupport::Ticket.new(ID: '1')
      other = Teamsupport::Customer.new(ID: '1')
      expect(ticket == other).to be false
    end
  end

  describe '#dateCreated' do
    it 'returns a Time when dateCreated is set' do
      ticket = Teamsupport::Ticket.new(ID: '1234', DateCreated: '4/4/2015 9:45 AM')
      expect(ticket.DateCreated).to be_a Time
      expect(ticket.DateCreated).to be_utc
    end
    it 'returns nil when dateCreated is not set' do
      ticket = Teamsupport::Ticket.new(ID: '1234')
      expect(ticket.DateCreated).to be_nil
    end
  end

  describe '#dateModified' do
    it 'returns a Time when dateModified is set' do
      ticket = Teamsupport::Ticket.new(ID: '1234', DateModified: '4/4/2015 10:00 AM')
      expect(ticket.DateModified).to be_a Time
      expect(ticket.DateModified).to be_utc
    end
    it 'returns nil when dateModified is not set' do
      ticket = Teamsupport::Ticket.new(ID: '1234')
      expect(ticket.DateModified).to be_nil
    end
  end

  describe '#IsClosed' do
    it 'returns a true boolean when IsClosed is "True" string' do
      ticket = Teamsupport::Ticket.new(ID: '1234', IsClosed: 'True')
      expect(ticket.IsClosed).to eql(true)
    end
    it 'returns false boolean when IsClosed is "False" string' do
      ticket = Teamsupport::Ticket.new(ID: '1234', IsClosed: 'False')
      expect(ticket.IsClosed).to eql(false)
    end
    it 'returns false boolean when IsClosed is not set' do
      ticket = Teamsupport::Ticket.new(ID: '1234')
      expect(ticket.IsClosed).to eql(false)
    end
  end

  describe '#IsVisibleOnPortal' do
    it 'returns a true boolean when IsVisibleOnPortal is "True" string' do
      ticket = Teamsupport::Ticket.new(ID: '1234', IsVisibleOnPortal: 'True')
      expect(ticket.IsVisibleOnPortal).to eql(true)
    end
    it 'returns false boolean when IsVisibleOnPortal is "False" string' do
      ticket = Teamsupport::Ticket.new(ID: '1234', IsVisibleOnPortal: 'False')
      expect(ticket.IsVisibleOnPortal).to eql(false)
    end
    it 'returns false boolean when IsVisibleOnPortal is not set' do
      ticket = Teamsupport::Ticket.new(ID: '1234')
      expect(ticket.IsVisibleOnPortal).to eql(false)
    end
  end

  describe '#IsKnowledgeBase' do
    it 'returns a true boolean when IsKnowledgeBase is "True" string' do
      ticket = Teamsupport::Ticket.new(ID: '1234', IsKnowledgeBase: 'True')
      expect(ticket.IsKnowledgeBase).to eql(true)
    end
    it 'returns false boolean when IsKnowledgeBase is "False" string' do
      ticket = Teamsupport::Ticket.new(ID: '1234', IsKnowledgeBase: 'False')
      expect(ticket.IsKnowledgeBase).to eql(false)
    end
    it 'returns false boolean when IsKnowledgeBase is not set' do
      ticket = Teamsupport::Ticket.new(ID: '1234')
      expect(ticket.IsKnowledgeBase).to eql(false)
    end
  end

  describe '#DateClosed' do
    it 'returns a Time when DateClosed is set' do
      ticket = Teamsupport::Ticket.new(ID: '1234', DateClosed: '4/4/2015 10:15 AM')
      expect(ticket.DateClosed).to be_a Time
      expect(ticket.DateClosed).to be_utc
    end
    it 'returns nil when DateClosed is not set' do
      ticket = Teamsupport::Ticket.new(ID: '1234')
      expect(ticket.DateClosed).to be_nil
    end
  end

  describe '#DueDate' do
    it 'returns a Time when DueDate is set' do
      ticket = Teamsupport::Ticket.new(ID: '1234', DueDate: '4/4/2015 10:15 AM')
      expect(ticket.DueDate).to be_a Time
      expect(ticket.DueDate).to be_utc
    end
    it 'returns nil when DueDate is not set' do
      ticket = Teamsupport::Ticket.new(ID: '1234')
      expect(ticket.DueDate).to be_nil
    end
  end

  describe '#customFields' do
    it 'returns custom field value when one custom field name is provided' do
      ticket = Teamsupport::Ticket.new(ID: '1234', CustomField1: '1111')
      expect(ticket.attrs[:CustomField1]).to eq('1111')
    end
    it 'returns custom field values when multiple custom field names are provided' do
      ticket = Teamsupport::Ticket.new(ID: '1234', CustomField1: '1111', CustomField2: '2222')
      expect(ticket.attrs[:CustomField1]).to eq('1111')
      expect(ticket.attrs[:CustomField2]).to eq('2222')
    end
    it 'returns nil when custom field is not set' do
      ticket = Teamsupport::Ticket.new(ID: '1234')
      expect(ticket.attrs[:CustomField1]).to be_nil
    end
  end
end
