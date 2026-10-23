module Ancon
  # `scope` is the tenant or outlet path the resource hangs off
  # (`/Tenants/{tenantId}`, `/Outlets/{outletId}`).
  class Resource
    attr_reader :client

    def initialize(client, scope)
      @client = client
      @scope = scope
    end

    protected

    def resource_path
      raise NotImplementedError, "Subclass must implement #resource_path"
    end

    def path(*segments)
      ["#{@scope}#{resource_path}", *segments].join("/")
    end
  end
end
