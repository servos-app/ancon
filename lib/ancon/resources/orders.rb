module Ancon
  module Resources
    # Completed sales. A refund is a new order with `parentOrderId`.
    #
    # To poll, filter on `modified` from when the previous poll started, minus
    # a minute of overlap, and match orders on `id`: overlap and the nightly
    # accounting run both return an order more than once.
    #
    # @example
    #   outlet.orders.detailed_list(filter: {modified: "gte:2026-10-23T11:59:00Z"}, limit: 1000)
    class Orders < Resource
      include Retrievable

      def detailed_list(**params)
        client.get(path("DetailedList"), params: Query.list(**params))
      end

      protected

      def resource_path
        "/Orders"
      end
    end
  end
end
