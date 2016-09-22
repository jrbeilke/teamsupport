require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
  minimum_coverage(90)
end

require 'teamsupport'
require 'rspec'
require 'stringio'
require 'tempfile'
require 'timecop'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow: 'coveralls.io')

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def a_delete(path)
  a_request(:delete, Teamsupport::REST::Request::BASE_URL + path)
end

def a_get(path)
  a_request(:get, Teamsupport::REST::Request::BASE_URL + path)
end

def a_post(path)
  a_request(:post, Teamsupport::REST::Request::BASE_URL + path)
end

def a_put(path)
  a_request(:put, Teamsupport::REST::Request::BASE_URL + path)
end

def stub_delete(path)
  stub_request(:delete, Teamsupport::REST::Request::BASE_URL + path)
end

def stub_get(path)
  stub_request(:get, Teamsupport::REST::Request::BASE_URL + path)
end

def stub_post(path)
  stub_request(:post, Teamsupport::REST::Request::BASE_URL + path)
end

def stub_put(path)
  stub_request(:put, Teamsupport::REST::Request::BASE_URL + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def capture_warning
  begin
    old_stderr = $stderr
    $stderr = StringIO.new
    yield
    result = $stderr.string
  ensure
    $stderr = old_stderr
  end
  result
end
