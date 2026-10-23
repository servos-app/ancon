require "json"
require "net/http"
require "openssl"
require "time"
require "uri"

require_relative "ancon/version"
require_relative "ancon/configuration"
require_relative "ancon/errors"
require_relative "ancon/response"
require_relative "ancon/request"
require_relative "ancon/connection"
require_relative "ancon/query"
require_relative "ancon/resource"
require_relative "ancon/actions"
require_relative "ancon/resources"
require_relative "ancon/tenant"
require_relative "ancon/outlet"
require_relative "ancon/client"

# Ancon public core API client.
#
# An access token is either tenant level (read/write everywhere) or outlet
# level (read on tenant data, read/write on its own outlet only). Endpoints
# hang off a tenant or an outlet, so the client hands out scopes for each:
#
# @example
#   client = Ancon::Client.new(access_token: ENV["ANCON_ACCESS_TOKEN"])
#   tenant_id = client.current_tenant.data.dig("tenant", "id")
#
#   client.tenant(tenant_id).products.list(limit: 50, filter: {name: "eq:Bacon burger"})
#   client.outlet(outlet_id).orders.detailed_list(filter: {modified: "gte:2026-10-23T12:00:00Z"})
#
# @see https://core-api.ancon.io/docs-v1/index.html
module Ancon
end
