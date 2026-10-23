module Ancon
  module Resources
    # Sales paid "on invoice", for the integration to bill and mark handled.
    # List with `Handled: false` for the ones still to bill.
    class Invoices < Resource
      include Listable

      def update_status(body)
        client.put(path("Status"), body: body)
      end

      protected

      def resource_path
        "/Invoices"
      end
    end
  end
end
