# Configuration

The TeamSupport API requires [authentication](http://help.teamsupport.com/1/en/topic/api) on all requests, and uses HTTP Basic Authentication over SSL.
The TeamSupport gem requires an api_key (your TeamSupport organization id), and api_secret (your TeamSupport API token) to be configured for authenticating with the TeamSupport API.

## Authentication

The TeamSupport gem requires an api_key (your TeamSupport organization id) and api_secret (your TeamSupport API token) to be configured for authenticating with the TeamSupport API.

```ruby
client = Teamsupport::REST::Client.new do |config|
  config.api_key    = "TEAMSUPPORT_ORGANIZATION_ID"
  config.api_secret = "TEAMSUPPORT_API_TOKEN"
end
```

If you prefer, you can pass in configuration as a `Hash`:

```ruby
config = {
  api_key:    "TEAMSUPPORT_ORGANIZATION_ID",
  api_secret: "TEAMSUPPORT_API_TOKEN",
}

client = Teamsupport::REST::Client.new(config)
```

Regardless of your configuration style, you should now be able to use this
client to make any TeamSupport API request. For example:

```ruby
client.customer(1)
```
