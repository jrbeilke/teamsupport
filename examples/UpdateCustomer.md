# Update Customer

This example assumes you have a configured TeamSupport REST `client`. Instructions
on how to configure a client can be found in [examples/Configuration.md][cfg].

[cfg]: https://github.com/jrbeilke/teamsupport/blob/master/examples/Configuration.md

The TeamSupport gem has the ability to update certain records in TeamSupport via the API. One such example is Customer records, which can be updated using the update_customer() method; passing in the customer ID to be updated along with a hash of the API field name and updated value.

```ruby
client.update_customer(1, {Name: "A Customer Name"})
```
