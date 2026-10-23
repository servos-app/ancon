# Ancon

A client for the Ancon POS public core API (core-api.ancon.io). Plain Ruby, no runtime dependencies.

## Installation

```ruby
gem "ancon", github: "servos-app/ancon"
```

## Usage

```ruby
client = Ancon::Client.new(access_token: ENV["ANCON_ACCESS_TOKEN"])
tenant_id = client.current_tenant.data.dig("tenant", "id")

client.tenant(tenant_id).products.list(limit: 50, filter: {created: ["gte:2026-01-01", "lte:2026-02-01"]})
client.outlet(outlet_id).orders.detailed_list(filter: {modified: "gte:2026-10-23T11:59:00Z"})
```

## Development

```sh
bundle install
bundle exec rake test
```

## License

MIT, see [LICENSE](LICENSE).
