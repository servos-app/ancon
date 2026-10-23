module Ancon
  # One venue under the tenant: its floor plan, open checks and sales.
  class Outlet
    attr_reader :client, :id

    def initialize(client, id)
      @client = client
      @id = id
    end

    def path
      "/Outlets/#{id}"
    end

    def retrieve
      client.get(path, version: "v1.1")
    end

    def update(body)
      client.put(path, body: body)
    end

    def checks = resource(Resources::Checks)

    def checkouts = resource(Resources::Checkouts)

    def client_groups = resource(Resources::ClientGroups)

    def clients = resource(Resources::Clients)

    def invoices = resource(Resources::Invoices)

    def orders = resource(Resources::Orders)

    def sections = resource(Resources::Sections)

    def settlement_reports = resource(Resources::SettlementReports)

    def tables = resource(Resources::Tables)

    def tickets = resource(Resources::Tickets)

    private

    def resource(resource_class)
      (@resources ||= {})[resource_class] ||= resource_class.new(client, path)
    end
  end
end
