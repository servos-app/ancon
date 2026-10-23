module Ancon
  module Resources
    # Payment methods.
    class WayOfPayments < Resource
      VERSION = "v1.2"

      def list(**params)
        client.get(path, params: Query.list(**params), version: VERSION)
      end

      # `outlets:` and `accounts:` add the outlets and ledger accounts the
      # payment method is set up with.
      def retrieve(id, outlets: nil, accounts: nil)
        params = {"Extent.Outlets" => outlets, "Extent.Accounts" => accounts}.compact
        client.get(path(id), params: params, version: VERSION)
      end

      protected

      def resource_path
        "/WayOfPayments"
      end
    end
  end
end
