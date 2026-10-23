module Ancon
  module Resources
    # A basket priced by Ancon and paid in one go, e.g. from a web shop.
    class Checkouts < Resource
      include Retrievable
      include Creatable
      include Deletable

      def recalculate_price(id)
        client.put(path(id, "RecalculatePrice"))
      end

      def apply_discount(id, body)
        client.put(path(id, "ApplyDiscount"), body: body)
      end

      def create_payment(id, body)
        client.post(path(id, "Payments"), body: body)
      end

      protected

      def resource_path
        "/Checkouts"
      end
    end
  end
end
