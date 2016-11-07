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

def a_delete(url, path)
  a_request(:delete, url + path)
end

def a_get(url, path)
  a_request(:get, url + path)
end

def a_post(url, path)
  a_request(:post, url + path)
end

def a_put(url, path)
  a_request(:put, url + path)
end

def stub_delete(url, path)
  stub_request(:delete, url + path)
end

def stub_get(url, path)
  stub_request(:get, url + path)
end

def stub_post(url, path)
  stub_request(:post, url + path)
end

def stub_put(url, path)
  stub_request(:put, url + path)
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
