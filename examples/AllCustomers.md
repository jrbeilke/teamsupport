# All Customers

This example assumes you have a configured TeamSupport REST `client`. Instructions
on how to configure a client can be found in [examples/Configuration.md][cfg].

[cfg]: https://github.com/jrbeilke/teamsupport/blob/master/examples/Configuration.md

The TeamSupport API offers a single /customers endpoint, which allows the gem to retrieve all Customer records in a single request.

```ruby
client.customers
```
