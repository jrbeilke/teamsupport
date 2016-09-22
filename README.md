# The Teamsupport Ruby Gem

[![Gem Version](http://img.shields.io/gem/v/teamsupport.svg)][gem]
[![Build Status](http://img.shields.io/travis/jrbeilke/teamsupport.svg)][travis]
[![Dependency Status](http://img.shields.io/gemnasium/jrbeilke/teamsupport.svg)][gemnasium]
[![Code Climate](http://img.shields.io/codeclimate/github/jrbeilke/teamsupport.svg)][codeclimate]
[![Coverage Status](http://img.shields.io/coveralls/jrbeilke/teamsupport.svg)][coveralls]
[![Inline docs](http://inch-ci.org/github/jrbeilke/teamsupport.svg?style=shields)][inchpages]

[gem]: https://rubygems.org/gems/teamsupport
[travis]: https://travis-ci.org/jrbeilke/teamsupport
[gemnasium]: https://gemnasium.com/jrbeilke/teamsupport
[codeclimate]: https://codeclimate.com/github/jrbeilke/teamsupport
[coveralls]: https://coveralls.io/r/jrbeilke/teamsupport
[inchpages]: http://inch-ci.org/github/jrbeilke/teamsupport

A Ruby interface to the Teamsupport API.

## Installation
    gem install twitter

## Documentation
[http://rdoc.info/gems/teamsupport][documentation]

[documentation]: http://rdoc.info/gems/teamsupport

To access custom fields you will need to use the attrs method along with the api field name:
```ruby
customer = client.customer(213747670)
customer.attrs[:CustomField1]
```

Caveat: The TeamSupport API currently returns boolean values as "True"/"False" strings. A workaround has been applied to the teamsupport gem that will return a boolean true/false for any of the standard TeamSupport values that should be a boolean (ie. IsActive on customers and IsClosed on tickets). Any additional custom fields that were created in TeamSupport will return the "True"/"False" string value instead of the proper boolean.

## Examples
[https://github.com/jrbeilke/teamsupport/tree/master/examples][examples]

[examples]: https://github.com/jrbeilke/teamsupport/tree/master/examples

## Configuration
The Teamsupport API requires you to authenticate via Basic Auth, using an
Organization ID (aka API Key) and an API Token (aka API Secret).

You'll need to configure these values before you make a request or else
you'll get the error:

    Bad Authentication data

You can pass configuration options as a block to `Teamsupport::REST::Client.new`.

```ruby
client = Teamsupport::REST::Client.new do |config|
  config.api_key    = "TEAMSUPPORT_ORGANIZATION_ID"
  config.api_secret = "TEAMSUPPORT_API_TOKEN"
end
```

## Usage Examples
After configuring a `client`, you can do the following things.

**Fetch a single customer (by organization ID)**

```ruby
client.customer(213747670)
```

**Fetch a list of customers with details (by organization ID, or by implicit authenticated parent organization)**

```ruby
client.customers
```

**Fetch a single product (by product ID)**

```ruby
client.product(213747670)
```

**Fetch a list of products with details (by product ID, or by implicit authenticated parent organization)**

```ruby
client.products
```

**Fetch a list of products for a customer (by customer ID)**

```ruby
client.customer_products(213747670)
```

**Fetch a single ticket (by ticket ID, or by ticket Number)**

```ruby
client.ticket(213747670)
```

**Fetch a list of tickets with details (by ticket ID, or by implicit authenticated parent organization)**

```ruby
client.tickets
```

**Fetch a list of tickets for a customer (by customer ID)**

```ruby
client.customer_tickets(213747670)
```

## Object Graph
![Entity-relationship diagram][erd]

[erd]: etc/erd.svg "Entity-relationship diagram"

This entity-relationship diagram is generated programatically. If you add or
remove any Teamsupport objects, please regenerate the ERD with the following
command:

    bundle exec rake erd

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby versions:

* Ruby 2.0.0
* Ruby 2.1
* Ruby 2.2
* JRuby 9.1.1.0

## Copyright
Copyright (c) 2016 Jon Beilke.
See [LICENSE][] for details.

[license]: LICENSE.md