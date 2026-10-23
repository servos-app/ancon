module Ancon
  # Tenant-level data: the catalog, payment methods, taxes and setup shared by
  # every outlet. Outlet-level tokens can read it but not change it.
  class Tenant
    attr_reader :client, :id

    def initialize(client, id)
      @client = client
      @id = id
    end

    def path
      "/Tenants/#{id}"
    end

    # The access token this client authenticates with.
    def current_integration
      client.get("#{path}/Integrations/Current")
    end

    def add_on_groups = resource(Resources::AddOnGroups)

    def discounts = resource(Resources::Discounts)

    def fees = resource(Resources::Fees)

    def ingredients = resource(Resources::Ingredients)

    def menu_trees = resource(Resources::MenuTrees)

    def metadata_templates = resource(Resources::MetadataTemplates)

    def product_groups = resource(Resources::ProductGroups)

    def products = resource(Resources::Products)

    def sale_sources = resource(Resources::SaleSources)

    def tags = resource(Resources::Tags)

    def taxes = resource(Resources::Taxes)

    def tenant_users = resource(Resources::TenantUsers)

    def upsell_groups = resource(Resources::UpsellGroups)

    def way_of_payments = resource(Resources::WayOfPayments)

    private

    def resource(resource_class)
      (@resources ||= {})[resource_class] ||= resource_class.new(client, path)
    end
  end
end
