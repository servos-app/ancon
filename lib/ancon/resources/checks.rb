module Ancon
  module Resources
    # Open bills at the outlet. These are the v2 endpoints; v1 sunsets on
    # 2028-09-01. A check a till is working on answers 423 (Errors::LockedError).
    class Checks < Resource
      VERSION = "v2"

      def list(**params)
        client.get(path, params: Query.list(**params), version: VERSION)
      end

      def list_for_sales_location(sales_location_id)
        client.get(path("SalesLocations", sales_location_id), version: VERSION)
      end

      def retrieve(id)
        client.get(path(id), version: VERSION)
      end

      def create(body)
        client.post(path, body: body, version: VERSION)
      end

      def delete(id, reason: nil)
        client.delete(path(id), body: {reason: reason}, version: VERSION)
      end

      # Adds an item to the open check on a sales location, opening one if
      # there is none.
      def add_item(body)
        client.post(path("AddItem"), body: body, version: VERSION)
      end

      def add_items(id, body)
        client.post(path(id, "Items"), body: body, version: VERSION)
      end

      def move(id, body)
        put(id, "Move", body)
      end

      def update_custom_name(id, body)
        put(id, "CustomName", body)
      end

      def update_custom_ticket(id, body)
        put(id, "CustomTicket", body)
      end

      def discount(id, body)
        put(id, "Discount", body)
      end

      def split(id, body)
        put(id, "Split", body)
      end

      def split_items(id, body)
        put(id, "Items/Split", body)
      end

      def discount_items(id, body)
        put(id, "Items/Discount", body)
      end

      def update_table_reservation(id, body)
        put(id, "TableReservationMetaData", body)
      end

      # Records a payment taken outside Ancon against the check.
      def create_integration_payment(id, body)
        put(id, "IntegrationPayment", body)
      end

      protected

      def resource_path
        "/Checks"
      end

      private

      def put(id, action, body)
        client.put(path(id, action), body: body, version: VERSION)
      end
    end
  end
end
