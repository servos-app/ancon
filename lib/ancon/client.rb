module Ancon
  class Client
    attr_reader :configuration

    def initialize(access_token:, language: nil, base_url: Configuration::BASE_URL, connection: Connection)
      @configuration = Configuration.new(access_token: access_token, language: language, base_url: base_url)
      @connection = connection
    end

    # The tenant the access token belongs to. Its id scopes the tenant endpoints.
    def current_tenant
      get("/Tenants")
    end

    # Every outlet under the tenant, or only its own for an outlet-level token.
    def outlets(**params)
      get("/Tenants/Outlets", params: Query.list(**params))
    end

    def tenant(tenant_id)
      Tenant.new(self, tenant_id)
    end

    def outlet(outlet_id)
      Outlet.new(self, outlet_id)
    end

    def get(path, version: "v1", params: {})
      perform(:get, version, path, params: params)
    end

    def post(path, body: nil, version: "v1")
      perform(:post, version, path, body: body)
    end

    def put(path, body: nil, version: "v1")
      perform(:put, version, path, body: body)
    end

    def delete(path, body: nil, version: "v1")
      perform(:delete, version, path, body: body)
    end

    private

    def perform(method, version, path, **options)
      response = @connection.perform(Request.build(method, configuration, version, path, **options))
      raise Errors.from(response) unless response.success?

      response
    end
  end
end
